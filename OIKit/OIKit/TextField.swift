//
//  TextField.swift
//  OIKit
//
//  Created by keenoi on 31/03/24.
//

import UIKit

public enum ImageSide {
    case left
    case right
}

extension UITextField {
    @discardableResult
    public func placeholder(_ text: String, font: UIFont? = nil) -> UITextField {
        self.placeholder = text
        if let font = font {
            let attributes = [NSAttributedString.Key.font: font]
            self.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
        }
        return self
    }

    
    @discardableResult
    public func text(_ text: String) -> UITextField {
        self.text = text
        return self
    }
    
    @discardableResult
    public func foregroundColor(_ color: UIColor) -> UITextField {
        self.textColor = color
        return self
    }
    
    @discardableResult
    public func font(_ size: CGFloat, weight: UIFont.Weight = .regular, design: FontDesign = .default) -> UITextField {
        let traits: [UIFontDescriptor.TraitKey: Any] = [.weight: weight]

        let fontDescriptor = UIFontDescriptor(fontAttributes: [
            .family: design.fontName,
            .traits: traits
        ])

        self.font = UIFont(descriptor: fontDescriptor, size: size)
        return self
    }
    
    @discardableResult
    public func font(_ style: UIFont.TextStyle) -> Self {
        self.font = UIFont.preferredFont(forTextStyle: style)
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont? = nil) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    public func padding(left: CGFloat? = nil, top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil) -> UITextField {
        let leftPadding = left ?? 0
        let topPadding = top ?? 0
        let rightPadding = right ?? 0
        let bottomPadding = bottom ?? 0
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: self.frame.size.height))
        self.rightView = paddingView2
        self.rightViewMode = .always
        
        let paddingView3 = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: topPadding))
        self.addSubview(paddingView3)
        
        let paddingView4 = UIView(frame: CGRect(x: 0, y: self.frame.size.height - bottomPadding, width: self.frame.size.width, height: bottomPadding))
        self.addSubview(paddingView4)
        
        return self
    }
    
    @discardableResult
    public func padding(_ value: CGFloat) -> UITextField {
        return padding(left: value, top: value, right: value, bottom: value)
    }
    
    @discardableResult
    public func addImage(position side: ImageSide, _ image: UIImage, padding: CGFloat, onTapGesture: (() -> Void)? = nil) -> UITextField {
        return addImage(position: side, image, paddingLeft: padding, paddingRight: padding, onTapGesture: onTapGesture)
    }
    
    @discardableResult
    public func addImage(position side: ImageSide, _ image: UIImage, setFrame size: CGSize? = nil, tintColorImage: UIColor? = nil, padding: CGFloat, onTapGesture: (() -> Void)? = nil) -> UITextField {
        var resizedImage = image
        if let size = size {
            resizedImage = image.resized(to: size)
        }
        var tintedImage = UIImage()
        if #available(iOS 13.0, *) {
            tintedImage = tintColorImage != nil ? resizedImage.withTintColor(tintColorImage!) : resizedImage
        } else {
            // Fallback on earlier versions
        }
        return addImage(position: side, tintedImage, paddingLeft: padding, paddingRight: padding, onTapGesture: onTapGesture)
    }
    
    @discardableResult
    func addImage(position side: ImageSide, _ image: UIImage, paddingLeft: CGFloat? = nil, paddingRight: CGFloat? = nil, onTapGesture: (() -> Void)? = nil) -> UITextField {
        let imageView = UIImageView(image: image)
        let totalPadding = (paddingLeft ?? 0) + (paddingRight ?? 0)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: imageView.frame.size.width + totalPadding, height: imageView.frame.size.height))
        imageView.contentMode = .center
        paddingView.addSubview(imageView)
        
        if side == .left {
            imageView.frame.origin.x = paddingLeft ?? 0
            self.leftView = paddingView
            self.leftViewMode = .always
        } else {
            imageView.frame.origin.x = paddingRight ?? 0
            self.rightView = paddingView
            self.rightViewMode = .always
        }
        
        if let onTapGesture = onTapGesture {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
            paddingView.addGestureRecognizer(tapGesture)
            paddingView.isUserInteractionEnabled = true
            objc_setAssociatedObject(paddingView, &AssociatedKeys.tapGesture, onTapGesture, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        return self
    }
}

extension UIImage {
    public func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension String {
    public enum ImageMode {
        case original
        case template
    }
    
    public func imageSFSymbols(_ mode: ImageMode? = nil) -> UIImage? {
        if #available(iOS 13.0, *) {
            guard let mode = mode else { return UIImage(systemName: self) }
            let imageName = self + (mode == .template ? ".fill" : "")
            return UIImage(systemName: imageName)
        } else {
            return nil
        }
    }
    
    public var renderingImage: UIImage? {
        return UIImage(named: self)
    }
}

extension UITextField {
    @discardableResult
    public func onEditingChange(_ action: @escaping (String) -> Void) -> UITextField {
        addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        objc_setAssociatedObject(self, &AssociatedKeys.textChangeAction, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return self
    }
    
    @objc private func handleTextChange() {
        guard let text = self.text else { return }
        if let action = objc_getAssociatedObject(self, &AssociatedKeys.textChangeAction) as? (String) -> Void {
            action(text)
        }
    }
}

private struct AssociatedKeys {
    static var tapGesture: UInt8 = 0
    static var submitAction: UInt8 = 0
    static var textChangeAction: UInt8 = 0
    static var returnAction: UInt8 = 0
    static var endEditingAction: UInt8 = 0
    static var beginEditingAction: UInt8 = 0
    static var shouldBeginEditingAction: UInt8 = 0
    static var shouldEndEditingAction: UInt8 = 0
    static var shouldClearAction: UInt8 = 0
    static var shouldChangeCharactersAction: UInt8 = 0
}

extension UITextField {
    @discardableResult
    public func onSubmit(_ action: @escaping () -> Void) -> UITextField {
        addTarget(self, action: #selector(handleSubmit), for: .editingDidEndOnExit)
        objc_setAssociatedObject(self, &AssociatedKeys.submitAction, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return self
    }
    
    @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
        if let onTapGesture = objc_getAssociatedObject(sender.view!, &AssociatedKeys.tapGesture) as? () -> Void {
            onTapGesture()
        }
    }
    
    @objc private func handleSubmit() {
        if let action = objc_getAssociatedObject(self, &AssociatedKeys.submitAction) as? () -> Void {
            action()
        }
    }
}

extension UITextField: UITextFieldDelegate {
    // Closure untuk menangani aksi ketika return button ditekan
    private var returnAction: (() -> Bool)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.returnAction) as? () -> Bool
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.returnAction, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @discardableResult
    public func onReturn(_ action: @escaping () -> Bool) -> UITextField {
        // Menyimpan closure sebagai returnAction
        returnAction = action
        // Mengatur delegate menjadi dirinya sendiri
        self.delegate = self
        return self
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Memanggil returnAction jika ada
        return textField.returnAction?() ?? true
    }
}

extension UITextField {
    // Closure untuk menangani aksi ketika textFieldDidEndEditing dipanggil
    private var endEditingAction: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.endEditingAction) as? () -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.endEditingAction, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // Closure untuk menangani aksi ketika textFieldDidBeginEditing dipanggil
    private var beginEditingAction: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.beginEditingAction) as? () -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.beginEditingAction, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @discardableResult
    public func onDidEndEditing(_ action: @escaping () -> Void) -> UITextField {
        // Menyimpan closure sebagai endEditingAction
        endEditingAction = action
        // Mengatur delegate menjadi dirinya sendiri
        self.delegate = self
        return self
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        // Memanggil endEditingAction jika ada
        textField.endEditingAction?()
    }
    
    @discardableResult
    public func onDidEndTap(_ action: @escaping () -> Void) -> UITextField {
        // Menyimpan closure sebagai beginEditingAction
        beginEditingAction = action
        // Mengatur delegate menjadi dirinya sendiri
        self.delegate = self
        return self
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        // Memanggil beginEditingAction jika ada
        textField.beginEditingAction?()
    }
}

extension UITextField {
    // Closure untuk menangani aksi ketika textFieldShouldBeginEditing dipanggil
    private var shouldBeginEditingAction: (() -> Bool)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.shouldBeginEditingAction) as? () -> Bool
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.shouldBeginEditingAction, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @discardableResult
    public func onDidTap(_ action: @escaping () -> Bool) -> UITextField {
        // Menyimpan closure sebagai shouldBeginEditingAction
        shouldBeginEditingAction = action
        // Mengatur delegate menjadi dirinya sendiri
        self.delegate = self
        return self
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // Memanggil shouldBeginEditingAction jika ada
        return textField.shouldBeginEditingAction?() ?? true
    }
}

extension UITextField {
    // Closure untuk menangani aksi ketika textFieldShouldEndEditing dipanggil
    private var shouldEndEditingAction: (() -> Bool)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.shouldEndEditingAction) as? () -> Bool
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.shouldEndEditingAction, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @discardableResult
    public func onShouldEndEditing(_ action: @escaping () -> Bool) -> UITextField {
        // Menyimpan closure sebagai shouldEndEditingAction
        shouldEndEditingAction = action
        // Mengatur delegate menjadi dirinya sendiri
        self.delegate = self
        return self
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // Memanggil shouldEndEditingAction jika ada
        return textField.shouldEndEditingAction?() ?? true
    }
}

extension UITextField {
    // Closure untuk menangani aksi ketika textFieldShouldClear dipanggil
    private var shouldClearAction: (() -> Bool)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.shouldClearAction) as? () -> Bool
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.shouldClearAction, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @discardableResult
    public func textFieldShouldClear(_ action: @escaping () -> Bool) -> UITextField {
        // Menyimpan closure sebagai shouldClearAction
        shouldClearAction = action
        // Mengatur delegate menjadi dirinya sendiri
        self.delegate = self
        return self
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // Memanggil shouldClearAction jika ada
        return textField.shouldClearAction?() ?? true
    }
}

extension UITextField {
    // Closure untuk menangani aksi ketika textField(_:shouldChangeCharactersIn:replacementString:) dipanggil
    private var shouldChangeCharactersAction: ((UITextField, NSRange, String) -> Bool)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.shouldChangeCharactersAction) as? (UITextField, NSRange, String) -> Bool
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.shouldChangeCharactersAction, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @discardableResult
    public func onChange(_ action: @escaping (UITextField, NSRange, String) -> Bool) -> UITextField {
        // Menyimpan closure sebagai shouldChangeCharactersAction
        shouldChangeCharactersAction = action
        // Mengatur delegate menjadi dirinya sendiri
        self.delegate = self
        return self
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Memanggil shouldChangeCharactersAction jika ada
        return textField.shouldChangeCharactersAction?(textField, range, string) ?? true
    }
}