//
//  Button.swift
//  OIKit
//
//  Created by keenoi on 22/01/24.
//

import UIKit

extension UIButton {
    public typealias Action = () -> Void
    
    private struct AssociatedKeys {
        static var actionKey: UInt8 = 0
    }
    
    private var action: Action? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? Action
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.actionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    convenience init(_ action: @escaping Action, setup: (UIButton) -> Void) {
        self.init(type: .system)
        content(action, setup: setup)
    }
    
    @discardableResult
    public func content(_ action: @escaping Action, setup: (UIButton) -> Void) -> UIButton {
        setup(self)
        self.action = action
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return self
    }
    
    convenience init(_ action: @escaping Action, setup: () -> Void) {
        self.init(type: .system)
        content(action, setup: setup)
    }
    
    @discardableResult
    public func content(_ action: @escaping Action, setup: () -> Void) -> UIButton {
        setup()
        self.action = action
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return self
    }
    
    @objc private func buttonTapped() {
        action?()
    }

    public func frame(width: CGFloat? = nil, height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    @discardableResult
    public func textAlignment(horizontal: UIControl.ContentHorizontalAlignment? = nil, vertical: UIControl.ContentVerticalAlignment? = nil, padding: CGFloat? = nil) -> UIButton {
        if let horizontal = horizontal {
            contentHorizontalAlignment = horizontal
        }
        if let vertical = vertical {
            contentVerticalAlignment = vertical
        }
        if let padding = padding {
            titleEdgeInsets = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: -padding)
        }
        return self
    }
    
    @discardableResult
    public func textAlignment(_ vertical: UIControl.ContentVerticalAlignment, _ padding: CGFloat? = nil) -> UIButton {
        contentVerticalAlignment = vertical
        if let padding = padding {
            switch vertical {
            case .top:
                titleEdgeInsets.top = padding
            case .bottom:
                titleEdgeInsets.bottom = padding
            case .center, .fill:
                titleEdgeInsets.top = padding / 2
                titleEdgeInsets.bottom = padding / 2
            @unknown default:
                break
            }
        }
        return self
    }
    
    @discardableResult
    public func textAlignment(_ horizontal: UIControl.ContentHorizontalAlignment, _ padding: CGFloat? = nil) -> UIButton {
        contentHorizontalAlignment = horizontal
        if let padding = padding {
            switch horizontal {
            case .left:
                titleEdgeInsets.left = padding
            case .right:
                titleEdgeInsets.right = padding
            case .center, .fill, .leading, .trailing:
                titleEdgeInsets.left = padding / 2
                titleEdgeInsets.right = padding / 2
            @unknown default:
                break
            }
        }
        return self
    }
    
    @discardableResult
    public func foregroundColor(_ color: UIColor, for state: UIControl.State = .normal) -> UIButton {
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    public func foregroundColor(_ hex: UInt32, for state: UIControl.State = .normal) -> UIButton {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    public func title(_ title: String?, for state: UIControl.State = .normal) -> UIButton {
        setTitle(title, for: state)
        return self
    }
    
    @discardableResult
    public func title(_ title: String?, fontSize size: CGFloat? = nil, for state: UIControl.State = .normal) -> UIButton {
        setTitle(title, for: state)
        if let size = size {
            titleLabel?.font = titleLabel?.font.withSize(size)
        }
        return self
    }
    
    @discardableResult
    public func title(_ title: String?, font fonts: UIFont? = nil, for state: UIControl.State = .normal) -> UIButton {
        setTitle(title, for: state)
        if let font = fonts {
            titleLabel?.font = font
        }
        return self
    }
    
    @discardableResult
    public func title(_ title: String?, fontSize size: CGFloat? = nil, font fonts: UIFont? = nil, for state: UIControl.State = .normal) -> UIButton {
        setTitle(title, for: state)
        if let size = size {
            titleLabel?.font = titleLabel?.font.withSize(size)
        }
        if let font = fonts {
            titleLabel?.font = font
        }
        return self
    }

    
    @discardableResult
    public func image(_ name: String, for state: UIControl.State = .normal) -> UIButton {
        if let image = UIImage(named: name) {
            setImage(image, for: state)
        }
        return self
    }
    
    @discardableResult
    public func image(systemName: String, for state: UIControl.State = .normal) -> UIButton {
        if #available(iOS 13.0, *) {
            if let image = UIImage(systemName: systemName) {
                setImage(image, for: state)
            }
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
    @discardableResult
    public func image(_ name: String, tintColor: UIColor, for state: UIControl.State = .normal) -> UIButton {
        if let image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate) {
            setImage(image, for: state)
            self.tintColor = tintColor
        }
        return self
    }

    @discardableResult
    public func image(systemName: String, tintColor: UIColor, for state: UIControl.State = .normal) -> UIButton {
        if #available(iOS 13.0, *) {
            if let image = UIImage(systemName: systemName)?.withRenderingMode(.alwaysTemplate) {
                setImage(image, for: state)
                self.tintColor = tintColor
            }
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
    @discardableResult
    public func image(_ name: String, at position: ImagePosition, spacing: CGFloat = 0, for state: UIControl.State = .normal) -> UIButton {
        if let image = UIImage(named: name) {
            setImage(image, for: state)
            positionImage(imagePosition: position, spacing: spacing)
        }
        return self
    }
    
    @discardableResult
    public func image(systemName: String, at position: ImagePosition, spacing: CGFloat = 0, for state: UIControl.State = .normal) -> UIButton {
        if #available(iOS 13.0, *) {
            if let image = UIImage(systemName: systemName) {
                setImage(image, for: state)
                positionImage(imagePosition: position, spacing: spacing)
            }
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
    @discardableResult
    public func image(_ name: String, at position: ImagePosition, spacing: CGFloat = 0, tintColor: UIColor, for state: UIControl.State = .normal) -> UIButton {
        if let image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate) {
            setImage(image, for: state)
            self.tintColor = tintColor
            positionImage(imagePosition: position, spacing: spacing)
        }
        return self
    }
    
    @discardableResult
    public func image(systemName: String, at position: ImagePosition, spacing: CGFloat = 0, tintColor: UIColor, for state: UIControl.State = .normal) -> UIButton {
        if #available(iOS 13.0, *) {
            if let image = UIImage(systemName: systemName)?.withRenderingMode(.alwaysTemplate) {
                setImage(image, for: state)
                self.tintColor = tintColor
                positionImage(imagePosition: position, spacing: spacing)
            }
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
    private func positionImage(imagePosition: ImagePosition, spacing: CGFloat = 0) {
        guard let imageView = imageView, let image = imageView.image, let titleLabel = titleLabel else {
            return
        }
        
        let imageInset: CGFloat = 0.0
        let titleInset: CGFloat = 0.0
        
        switch imagePosition {
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageInset - spacing, bottom: 0, right: imageInset)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: titleInset, bottom: 0, right: -titleInset)
        case .right:
            let imageSize = image.size
            imageEdgeInsets = UIEdgeInsets(top: 0, left: titleLabel.frame.size.width + titleInset + (spacing + 30), bottom: 0, right: -titleLabel.frame.size.width - titleInset - (spacing + 30))
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width - imageInset, bottom: 0, right: imageSize.width + imageInset)
        }
    }
}

public enum ImagePosition {
    case left
    case right
}
