//
//  Button.swift
//  OIKit
//
//  Created by keenoi on 22/01/24.
//

import UIKit

private var actionKeys: UInt8 = 0
extension UIButton {

    public typealias Action = () -> Void
    
    private struct AssociatedKeys {
        static var actionKey = "actionKey"
    }

    private var action: Action? {
        get {
            return objc_getAssociatedObject(self, &actionKeys) as? Action
        }
        set {
            objc_setAssociatedObject(self, &actionKeys, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    convenience init(_ action: @escaping Action, label block: (UIButton) -> Void) {
        self.init(type: .system)
        content(action, label: block)
    }

    @discardableResult
    public func content(_ action: @escaping Action, label block: (UIButton) -> Void) -> UIButton {
        block(self)
        self.action = action
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return self
    }

    @objc private func buttonTapped() {
        action?()
    }

    public func frame(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    @discardableResult
    public func textColor(_ color: UIColor, for state: UIControl.State = .normal) -> UIButton {
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    public func textColor(_ hex: UInt32, for state: UIControl.State = .normal) -> UIButton {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        setTitleColor(color, for: state)
        return self
    }
}
