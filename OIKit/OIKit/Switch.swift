//
//  Switch.swift
//  OIKit
//
//  Created by keenoi on 16/04/24.
//

import UIKit

public extension UISwitch {
    @discardableResult
    func frame(x: CGFloat, y: CGFloat) -> Self {
        self.transform = CGAffineTransform(scaleX: x, y: y)
        return self
    }
    
    @discardableResult
    func isOn(_ isOn: Bool) -> Self {
        self.isOn = isOn
        return self
    }
    
    @discardableResult
    func onTintColor(_ color: UIColor) -> Self {
        self.onTintColor = color
        return self
    }
    
    @discardableResult
    func thumbTintColor(_ color: UIColor) -> Self {
        self.thumbTintColor = color
        return self
    }
    
    @discardableResult
    func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    @discardableResult
    func onTintColor(_ hex: Int) -> Self {
        let color = UIColor(hex: UInt32(hex))
        self.onTintColor = color
        return self
    }
    
    @discardableResult
    func thumbTintColor(_ hex: Int) -> Self {
        let color = UIColor(hex: UInt32(hex))
        self.thumbTintColor = color
        return self
    }
    
    @discardableResult
    func tintColor(_ hex: Int) -> Self {
        let color = UIColor(hex: UInt32(hex))
        self.tintColor = color
        return self
    }
    
    @discardableResult
    func onImage(_ image: UIImage?) -> Self {
        self.onImage = image
        return self
    }
    
    @discardableResult
    func offImage(_ image: UIImage?) -> Self {
        self.offImage = image
        return self
    }
    
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func onChange(_ handler: @escaping (UISwitch) -> Void) -> Self {
        self.addTarget(self, action: #selector(handleValueChanged(_:)), for: .valueChanged)
        self.valueChangedHandler = handler
        return self
    }
    
    private struct AssociatedKeys {
        static var valueChangedHandler: UInt8 = 0
    }
    
    private var valueChangedHandler: ((UISwitch) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.valueChangedHandler) as? (UISwitch) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.valueChangedHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc private func handleValueChanged(_ sender: UISwitch) {
        valueChangedHandler?(sender)
    }
}