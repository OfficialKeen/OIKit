//
//  View.swift
//  OIKit
//
//  Created by keenoi on 17/01/24.
//

import UIKit

extension UIView {
    @discardableResult
    public func background(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func isHidden(_ bool: Bool = true) -> Self {
        self.isHidden = bool
        return self
    }
    
    @discardableResult
    public func background(_ hex: UInt32) -> Self {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return background(color)
    }
    
    @discardableResult
    public func width(_ width: CGFloat) -> Self {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    public func height(_ height: CGFloat) -> Self {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    public func frame(width: CGFloat, height: CGFloat) -> Self {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    public func cornerRadius(_ radius: CGFloat? = nil) -> Self {
        self.layer.cornerRadius = radius ?? 0
        self.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func cornerRadius(_ radius: CGFloat? = nil, withShadow shadowConfig: (() -> Shadow)? = nil) -> Self {
        self.layer.cornerRadius = radius ?? 0
        self.layer.masksToBounds = true
        
        if let shadowConfig = shadowConfig?() {
            applyShadow(with: shadowConfig)
        }
        return self
    }
    
    @discardableResult
    public func cornerRadius(_ corner: UIRectCorner, _ radius: CGFloat, withShadow shadowConfig: (() -> Shadow)? = nil) -> Self {
        layer.maskedCorners = []
        
        if corner.contains(.topLeft) {
            layer.maskedCorners.insert(.layerMinXMinYCorner)
        }
        
        if corner.contains(.bottomLeft) {
            layer.maskedCorners.insert(.layerMinXMaxYCorner)
        }
        
        if corner.contains(.topRight) {
            layer.maskedCorners.insert(.layerMaxXMinYCorner)
        }
        
        if corner.contains(.bottomRight) {
            layer.maskedCorners.insert(.layerMaxXMaxYCorner)
        }
        
        layer.cornerRadius = radius
        layer.masksToBounds = true
        
        if let shadowConfig = shadowConfig?() {
            applyShadow(with: shadowConfig)
        }
        
        return self
    }
    
    private func applyShadow(with config: Shadow) {
        layer.masksToBounds = false
        layer.shadowColor = config.color.cgColor
        layer.shadowOpacity = config.opacity
        layer.shadowOffset = config.offset
        layer.shadowRadius = config.radius
    }
    
    @discardableResult
    public func stroke(_ color: UIColor? = .black, lineWidth: CGFloat? = 1) -> Self {
        self.layer.borderColor = color?.cgColor
        self.layer.borderWidth = lineWidth ?? 0
        return self
    }
    
    public func stroke(_ hexColor: UInt32, lineWidth: CGFloat? = 1) -> Self {
        let color = UIColor(hex: hexColor)
        return stroke(color, lineWidth: lineWidth)
    }
    
    @discardableResult
    public func overlay(_ overlay: (UIView) -> Void) -> Self {
        let overlayView = UIView()
        overlay(overlayView)
        
        addSubview(overlayView)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        return self
    }
}

public struct Shadow {
    var color: UIColor
    var radius: CGFloat
    var opacity: Float
    var offset: CGSize
}

extension UIView {
    @discardableResult
    private func addView(paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, @UIStackViewBuilder content: () -> [UIView]) -> UIView {
        let container = UIView()
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: guide.topAnchor, constant: paddingTop),
            container.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: paddingLeft),
            container.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -paddingRight),
            container.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -paddingBottom)
        ])
        
        let views = content()
        for view in views {
            container.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: container.topAnchor),
                view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
        }
        
        return container
    }
    
    @discardableResult
    public func addView(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0, @UIStackViewBuilder content: () -> [UIView]) -> UIView {
        return addView(paddingTop: top, paddingLeft: left, paddingBottom: bottom, paddingRight: right, content: content)
    }
    
    @discardableResult
    public func addView(padding: CGFloat = 0, @UIStackViewBuilder content: () -> [UIView]) -> UIView {
        return addView(paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: padding, content: content)
    }
    
    @discardableResult
    public func addView(padding: CGFloat = 0, verticalPadding: CGFloat = 0, horizontalPadding: CGFloat = 0, @UIStackViewBuilder content: () -> [UIView]) -> UIView {
        return addView(paddingTop: padding + verticalPadding, paddingLeft: padding + horizontalPadding, paddingBottom: padding + verticalPadding, paddingRight: padding + horizontalPadding, content: content)
    }
}
