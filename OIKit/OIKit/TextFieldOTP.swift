//
//  TextFieldOTP.swift
//  OIKit
//
//  Created by keenoi on 17/09/25.
//

import UIKit

protocol OTPFieldDelegate: AnyObject {
    func didPressBackspace(in field: OTPTextField)
}

class OTPTextField: UITextField {
    weak var otpDelegate: OTPFieldDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        if text?.isEmpty == true {
            otpDelegate?.didPressBackspace(in: self)
        }
    }
}

public class TextFieldOTP: UIStackView {
    
    private var mode: OTPKeyboardMode = .numeric
    
    private var filledBorderColor: UIColor = .systemPink
    private var emptyBorderColor:  UIColor = .systemGray
    private var emptyBgColor: UIColor = .clear
    private var filledBgColor: UIColor = .clear
    
    private var digitCount: Int = 4
    private var onComplete: ((String) -> Void)?
    
    private var textFields: [OTPTextField] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - SwiftUI-style chaining
    @discardableResult
    public func digit(_ count: Int) -> Self {
        self.digitCount = max(3, min(count, 8)) // clamp 3-8
        rebuildFields()
        return self
    }
    
    @discardableResult
    public func textColor(_ color: UIColor) -> Self {
        textFields.forEach { $0.textColor = color }
        return self
    }
    
    @discardableResult
    public func textSize(_ size: CGFloat) -> Self {
        textFields.forEach {
            $0.font = .systemFont(ofSize: size)
        }
        return self
    }
    
    @discardableResult
    public func textSize(_ size: CGFloat, weight: UIFont.Weight = .regular) -> Self {
        textFields.forEach {
            $0.font = .systemFont(ofSize: size, weight: weight)
        }
        return self
    }
    
    @discardableResult
    public func textColor(hex: UInt) -> Self {
        let color = UIColor(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255,
            blue: CGFloat(hex & 0x0000FF) / 255,
            alpha: 1
        )
        return textColor(color)
    }
    
    @discardableResult
    public func spacing(_ value: CGFloat) -> Self {
        self.spacing = value
        return self
    }
    
    @discardableResult
    public func strokeColors(_ from: UIColor = .systemGray,
                             to: UIColor = .systemGray) -> Self {
        self.emptyBorderColor  = from
        self.filledBorderColor = to
        textFields.forEach { updateBorderColor(for: $0) }
        return self
    }
    
    @discardableResult
    public func strokeColors(_ from: UInt = 0xF0F0F0,
                             to: UInt = 0xDDDDDD) -> Self {
        let emptyColor = UIColor(
            red: CGFloat((from & 0xFF0000) >> 16) / 255,
            green: CGFloat((from & 0x00FF00) >> 8) / 255,
            blue: CGFloat(from & 0x0000FF) / 255,
            alpha: 1
        )
        let filledColor = UIColor(
            red: CGFloat((to & 0xFF0000) >> 16) / 255,
            green: CGFloat((to & 0x00FF00) >> 8) / 255,
            blue: CGFloat(to & 0x0000FF) / 255,
            alpha: 1
        )
        return strokeColors(emptyColor, to: filledColor)
    }
    
    @discardableResult
    public func backgroundColors(_ from: UIColor = .systemGray,
                                 to: UIColor = .systemTeal) -> Self {
        self.emptyBgColor = from
        self.filledBgColor = to
        refreshAllBackgroundColors()
        return self
    }
    
    @discardableResult
    public func backgroundColors(_ from: UInt = 0xF0F0F0,
                                 to: UInt = 0xDDDDDD) -> Self {
        let emptyColor = UIColor(
            red: CGFloat((from & 0xFF0000) >> 16) / 255,
            green: CGFloat((from & 0x00FF00) >> 8) / 255,
            blue: CGFloat(from & 0x0000FF) / 255,
            alpha: 1
        )
        let filledColor = UIColor(
            red: CGFloat((to & 0xFF0000) >> 16) / 255,
            green: CGFloat((to & 0x00FF00) >> 8) / 255,
            blue: CGFloat(to & 0x0000FF) / 255,
            alpha: 1
        )
        return backgroundColors(emptyColor, to: filledColor)
    }
    
    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> Self {
        textFields.forEach {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = radius
        }
        return self
    }
    
    @discardableResult
    public func onCodeCompleted(_ action: @escaping (String) -> Void) -> Self {
        self.onComplete = action
        return self
    }
    
    // MARK: - Setup
    private func setup() {
        axis = .horizontal
        distribution = .fillEqually
        rebuildFields()
    }
    
    private func refreshAllVisuals() {
        textFields.forEach {
            updateBorderColor(for: $0)
            updateBackgroundColor(for: $0)
        }
    }
    
    private func updateBackgroundColor(for field: OTPTextField) {
        let isFilled = !(field.text ?? "").isEmpty
        field.backgroundColor = isFilled ? filledBgColor : emptyBgColor
    }
    
    private func refreshAllBackgroundColors() {
        textFields.forEach { updateBackgroundColor(for: $0) }
    }
    
    private func rebuildFields() {
        textFields.forEach { $0.removeFromSuperview() }
        textFields.removeAll()
        
        for _ in 0..<digitCount {
            let field = OTPTextField()
            field.textAlignment = .center
            field.keyboardType = .numberPad
            field.font = .systemFont(ofSize: 24)
            field.borderStyle = .none
            field.delegate = self
            field.otpDelegate = self
            textFields.append(field)
            addArrangedSubview(field)
        }
        
        textFields.first?.becomeFirstResponder()
    }
    
    private func code() -> String {
        textFields.compactMap { $0.text }.joined()
    }
    
    private func animate(_ field: UITextField) {
        UIView.animate(withDuration: 0.08, animations: {
            field.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            field.alpha = 0.6
        }) { _ in
            UIView.animate(withDuration: 0.08) {
                field.transform = .identity
                field.alpha = 1
            }
        }
    }
    
    private func updateBorderColor(for field: OTPTextField) {
        let isFilled = !(field.text ?? "").isEmpty
        let targetColor = isFilled ? filledBorderColor : emptyBorderColor
        
        // 1) roundedRect atau pill
        if field.layer.borderWidth > 0 {
            field.layer.borderColor = targetColor.cgColor
        }
        
        // 2) bottomLine
        if let line = field.layer.sublayers?.first(where: { $0.name == "borderLayer" }) {
            line.backgroundColor = targetColor.cgColor
        }
    }
    
    @discardableResult
    public func stroke(width: CGFloat = 0,
                       corner: CGFloat = 0,
                       shadowRadius: CGFloat = 0,
                       shadowColor: UIColor = .black,
                       shadowOpacity: Float = 0.15,
                       shadowOffset: CGSize = CGSize(width: 0, height: 2)) -> Self {
        
        textFields.forEach {
            $0.borderStyle = .none
            $0.layer.masksToBounds = false
            $0.layer.cornerRadius = corner
            $0.layer.borderWidth = width
            
            // Shadow
            $0.layer.shadowRadius = shadowRadius
            $0.layer.shadowColor = shadowColor.cgColor
            $0.layer.shadowOpacity = shadowRadius > 0 ? shadowOpacity : 0
            $0.layer.shadowOffset = shadowOffset
        }
        
        refreshAllVisuals()
        return self
    }
    
    @discardableResult
    func stroke(_ style: OTPBorderStyle) -> Self {
        textFields.forEach { applyBorder(style, to: $0) }
        return self
    }
    
    private func applyBorder(_ style: OTPBorderStyle, to field: OTPTextField) {
        switch style {
        case .none:
            field.borderStyle = .none
            field.layer.sublayers?.removeAll { $0.name == "borderLayer" }
            
        case .bottomLine(let color, let thickness):
            field.borderStyle = .none
            field.layer.sublayers?.removeAll { $0.name == "borderLayer" }
            let line = CALayer()
            line.name = "borderLayer"
            line.backgroundColor = color.cgColor
            line.frame = CGRect(x: 0, y: field.bounds.height - thickness,
                                width: field.bounds.width, height: thickness)
            field.layer.addSublayer(line)
            
        case .roundedRect(let color, let width, let corner):
            field.borderStyle = .none
            field.layer.masksToBounds = true
            field.layer.cornerRadius = corner
            field.layer.borderColor = color.cgColor
            field.layer.borderWidth = width
            
        case .pill(let color):
            field.borderStyle = .none
            field.layer.masksToBounds = true
            field.layer.cornerRadius = field.bounds.height / 2
            field.layer.borderColor = color.cgColor
            field.layer.borderWidth = 2
            
        case .solidColor(let color):
            field.borderStyle = .none
            field.layer.masksToBounds = true
            field.layer.cornerRadius = 8
            field.layer.borderColor = color.cgColor
            field.layer.borderWidth = 2
            
        case .hex(let rgb):
            let color = UIColor(
                red: CGFloat((rgb & 0xFF0000) >> 16) / 255,
                green: CGFloat((rgb & 0x00FF00) >> 8) / 255,
                blue: CGFloat(rgb & 0x0000FF) / 255,
                alpha: 1
            )
            applyBorder(.solidColor(color), to: field)
        }
    }
}

// MARK: - UITextFieldDelegate
extension TextFieldOTP: UITextFieldDelegate {
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        
        guard let field = textField as? OTPTextField,
              let currentIndex = textFields.firstIndex(of: field) else { return false }
        
        // Allow only 0-9 and max 1 character
        guard string.count <= 1, Int(string) != nil || string.isEmpty else { return false }
        
        // Kalau field udah terisi & user ngetik baru → langsung timpa
        if !string.isEmpty, textField.text?.isEmpty == false {
            textField.text = string
            updateBorderColor(for: field)
            animate(textField)
            // Auto move next
            let nextIndex = currentIndex + 1
            if nextIndex < textFields.count {
                textFields[nextIndex].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
                onComplete?(code())
            }
            return false
        }
        
        // Behavior normal (kosong → isi, atau delete)
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        textField.text = newText
        
        if !newText.isEmpty {
            let nextIndex = currentIndex + 1
            if nextIndex < textFields.count {
                textFields[nextIndex].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
                onComplete?(code())
            }
        }
        
        refreshAllVisuals()
        return false
    }
}

// MARK: - OTPFieldDelegate
extension TextFieldOTP: OTPFieldDelegate {
    func didPressBackspace(in field: OTPTextField) {
        guard let index = textFields.firstIndex(of: field), index > 0 else { return }
        let prev = textFields[index - 1]
        prev.text = ""
        updateBorderColor(for: prev)
        animate(prev)
        refreshAllVisuals()
        prev.becomeFirstResponder()
    }
}

enum OTPBorderStyle {
    case none
    case bottomLine(color: UIColor, thickness: CGFloat = 2)
    case roundedRect(color: UIColor, width: CGFloat = 1, corner: CGFloat = 8)
    case pill(color: UIColor)
    case solidColor(UIColor)
    case hex(UInt32)
}

public enum OTPKeyboardMode {
    case numeric      // 0-9
    case alphanumeric // A-Z, a-z, 0-9
}

extension TextFieldOTP {
    private func applyMode() {
        textFields.forEach {
            switch mode {
            case .numeric:
                $0.keyboardType = .numberPad
            case .alphanumeric:
                $0.keyboardType = .asciiCapable   // full keyboard
            }
        }
    }
    
    @discardableResult
    public func keyboardMode(_ mode: OTPKeyboardMode) -> Self {
        self.mode = mode
        applyMode()
        return self
    }
}
