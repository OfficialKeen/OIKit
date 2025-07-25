//
//  View.swift
//  OIKit
//
//  Created by keenoi on 17/01/24.
//

import UIKit

public class View: UIView {
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
    public func background(_ hex: UInt) -> Self {
        let color = UIColor(hex: UInt32(hex))
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
    public func cornerRadius(_ corner: UIRectCorner, _ radius: CGFloat) -> Self {
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
    
    @discardableResult
    public func stroke(_ hexColor: UInt, lineWidth: CGFloat? = 1) -> Self {
        let color = UIColor(hex: UInt32(hexColor))
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

extension UIView {
    @discardableResult
    public func addView(paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, @UIStackViewBuilder content: () -> [UIView]) -> UIView {
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

extension View {
    @discardableResult
    public func width(_ state: SBinding<CGFloat>) -> Self {
        state.didSet = { [weak self] newWidth in
            self?.widthAnchor.constraint(equalToConstant: newWidth).isActive = true
        }
        
        state.didSet?(state.wrappedValue)
        return self
    }
    
    @discardableResult
    public func height(_ state: SBinding<CGFloat>) -> Self {
        state.didSet = { [weak self] newHeight in
            self?.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
        }
        
        state.didSet?(state.wrappedValue)
        return self
    }
    
    @discardableResult
    public func background(_ state: SBinding<UIColor>, opacity: CGFloat = 1.0) -> Self {
        state.didSet = { [weak self] newColor in
            self?.backgroundColor = newColor.withAlphaComponent(opacity)
        }
        
        state.didSet?(state.wrappedValue)
        return self
    }
    
    @discardableResult
    public func background(_ state: SBinding<UInt>, opacity: CGFloat = 1.0) -> Self {
        state.didSet = { [weak self] hexValue in
            let color = UIColor(hex: UInt32(hexValue))
            self?.backgroundColor = color
        }
        
        state.didSet?(state.wrappedValue)
        return self
    }
    
    @discardableResult
    public func cornerRadius(_ radius: SBinding<CGFloat?>) -> Self {
        radius.didSet = { [weak self] newRadius in
            self?.layer.cornerRadius = newRadius ?? 0
            self?.layer.masksToBounds = true
        }
        radius.didSet?(radius.wrappedValue)
        return self
    }
    
    @discardableResult
    public func cornerRadius(_ radiusState: SBinding<CGFloat>) -> Self {
        radiusState.didSet = { [weak self] newRadius in
            self?.layer.cornerRadius = newRadius
            self?.layer.masksToBounds = true
        }
        radiusState.didSet?(radiusState.wrappedValue)
        return self
    }
    
    @discardableResult
    public func isHidden(_ state: SBinding<Bool>) -> Self {
        self.isHidden = state.wrappedValue
        state.didSet = { [weak self] newValue in
            self?.isHidden = newValue
        }
        return self
    }
    
    @discardableResult
    public func isUserEnabled(_ isEnabled: Bool = true) -> Self {
        self.isUserInteractionEnabled = isEnabled
        return self
    }
    
    @discardableResult
    public func isUserEnabled(_ isEnabled: SBinding<Bool>) -> Self {
        isEnabled.didSet = { [weak self] newIsEnabled in
            self?.isUserInteractionEnabled = newIsEnabled
        }
        isEnabled.didSet?(isEnabled.wrappedValue)
        return self
    }
}

extension View {
    @discardableResult
    public func overlay(_ radius: CGFloat? = nil, withShadow shadowConfig: (() -> Shadow)? = nil) -> Self {
        self.layer.cornerRadius = radius ?? 0
        self.layer.masksToBounds = true
        
        if let shadowConfig = shadowConfig?() {
            applyShadow(with: shadowConfig)
        }
        return self
    }

    @discardableResult
    public func overlay(_ corner: UIRectCorner, _ radius: CGFloat, withShadow shadowConfig: (() -> Shadow)? = nil) -> Self {
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

}

public struct Shadow {
    public init(color: UIColor, radius: CGFloat, opacity: Float, offset: CGSize) {
        self.color = color
        self.radius = radius
        self.opacity = opacity
        self.offset = offset
    }

    var color: UIColor
    var radius: CGFloat
    var opacity: Float
    var offset: CGSize
}

extension View {
    @discardableResult
    public func shadow(color: UIColor, opacity: Float, radius: CGFloat, offset: CGSize) -> Self {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        return self
    }
    
    @discardableResult
    public func shadow(color: UInt, opacity: Float, radius: CGFloat, offset: CGSize) -> Self {
        let hexColor = UIColor(hex: UInt32(color))
        self.layer.shadowColor = hexColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        return self
    }
}

// MARK: CenteredView
public enum CenteredView {
    case centerX
    case centerY
    case centerXY
    case none
}

extension UIView {
    @discardableResult
    public func addView(
        paddingTop: CGFloat = 0,
        paddingLeft: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingRight: CGFloat = 0,
        centered: CenteredView = .none,
        @UIStackViewBuilder content: () -> [UIView]
    ) -> UIView {
        let container = UIView()
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = safeAreaLayoutGuide
        
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
            
            // Handle centering logic
            let centerX = centered == .centerX || centered == .centerXY
            let centerY = centered == .centerY || centered == .centerXY
            
            if centerX {
                view.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
            } else {
                view.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
                view.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
            }
            
            if centerY {
                view.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
            } else {
                view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
                view.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
            }
        }
        return container
    }
    
    // Overloads yang compatible
    @discardableResult
    public func addView(
        top: CGFloat = 0,
        left: CGFloat = 0,
        bottom: CGFloat = 0,
        right: CGFloat = 0,
        centered: CenteredView = .none,
        @UIStackViewBuilder content: () -> [UIView]
    ) -> UIView {
        addView(paddingTop: top, paddingLeft: left, paddingBottom: bottom,
                paddingRight: right, centered: centered, content: content)
    }
    
    @discardableResult
    public func addView(
        padding: CGFloat = 0,
        centered: CenteredView = .none,
        @UIStackViewBuilder content: () -> [UIView]
    ) -> UIView {
        addView(paddingTop: padding, paddingLeft: padding, paddingBottom: padding,
                paddingRight: padding, centered: centered, content: content)
    }
}

// Helper yang updated
public func Centered(
    _ centered: CenteredView = .none,
    padding: CGFloat = 0,
    @UIStackViewBuilder content: () -> [UIView]
) -> UIView {
    let dummy = UIView()
    return dummy.addView(padding: padding, centered: centered, content: content)
}
