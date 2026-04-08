//
//  UIView+Extension.swift
//  OIKit
//
//  Created by Keen on 08/04/26.
//

import UIKit

extension UIView {
    @discardableResult
    public func rotationEffect(degrees: CGFloat) -> Self {
        self.transform = CGAffineTransform(rotationAngle: degrees * .pi / 180)
        return self
    }

    @discardableResult
    public func rotationEffect(radians: CGFloat) -> Self {
        self.transform = CGAffineTransform(rotationAngle: radians)
        return self
    }
    
    @discardableResult
    public func opacity(_ value: CGFloat) -> Self {
        self.alpha = value
        return self
    }
    
    @discardableResult
    public func opacity(_ state: SBinding<CGFloat>) -> Self {
        self.alpha = state.wrappedValue
        state.didSet = { [weak self] newValue in
            self?.alpha = newValue
        }
        return self
    }
    
    @discardableResult
    public func opacity(_ percent: Int) -> Self {
        let value = CGFloat(percent) / 100
        self.alpha = value
        return self
    }
    
    @discardableResult
    public func opacity(_ state: SBinding<Int>) -> Self {
        state.didSet = { [weak self] newValue in
            self?.alpha = CGFloat(newValue) / 100
        }
        state.didSet?(state.wrappedValue)
        return self
    }
}

extension UIView {
    func applyGradient(colors: [UInt], locations: [CGFloat]?, angle: CGFloat) {
        let gradientName = "dslGradientLayer"
        layer.sublayers?.filter { $0.name == gradientName }.forEach { $0.removeFromSuperlayer() }

        let gradient = CAGradientLayer()
        gradient.name = gradientName

        gradient.colors = colors.map {
            UIColor(hex: UInt32($0)).cgColor
        }

        if let locations,
           locations.count == colors.count {
            gradient.locations = locations.map {
                NSNumber(value: Double($0))
            }
        }

        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint   = CGPoint(x: 1, y: 0.5)

        layer.insertSublayer(gradient, at: 0)

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let extra: CGFloat = 2
            gradient.frame = CGRect(
                x: -self.bounds.width * (extra - 1) / 2,
                y: -self.bounds.height * (extra - 1) / 2,
                width: self.bounds.width * extra,
                height: self.bounds.height * extra
            )
            let radians = angle * .pi / 180
            gradient.setAffineTransform(
                CGAffineTransform(rotationAngle: radians)
            )
        }
    }
}

extension UIView {
    @discardableResult
    public func gradient(colors: [UInt], locations: [CGFloat]? = nil, angle: CGFloat = 0) -> Self {
        applyGradient(colors: colors, locations: locations, angle: angle)
        return self
    }
}

extension UIView {
    @discardableResult
    public func gradient(colors: SBinding<[UInt]>, locations: [CGFloat]? = nil, angle: CGFloat = 0) -> Self {
        applyGradient(colors: colors.wrappedValue, locations: locations, angle: angle)
        colors.didSet = { [weak self] newValue in
            self?.applyGradient(colors: newValue, locations: locations, angle: angle)
        }
        return self
    }
}

extension UIView {
    @discardableResult
    public func gradient(colors: [UInt], locations: SBinding<[CGFloat]?>, angle: CGFloat = 0) -> Self {
        applyGradient(colors: colors, locations: locations.wrappedValue, angle: angle)
        locations.didSet = { [weak self] newValue in
            self?.applyGradient(colors: colors, locations: newValue, angle: angle)
        }
        return self
    }
}

extension UIView {
    @discardableResult
    public func gradient(colors: [UInt], locations: [CGFloat]? = nil, angle: SBinding<CGFloat>) -> Self {
        applyGradient(colors: colors, locations: locations, angle: angle.wrappedValue)
        angle.didSet = { [weak self] newValue in
            self?.applyGradient(colors: colors, locations: locations, angle: newValue)
        }
        return self
    }
}

extension UIView {
    @discardableResult
    public func gradient(colors: SBinding<[UInt]>, locations: SBinding<[CGFloat]?>, angle: SBinding<CGFloat>) -> Self {
        func update() {
            self.applyGradient(colors: colors.wrappedValue, locations: locations.wrappedValue, angle: angle.wrappedValue)
        }
        update()
        colors.didSet = { _ in update() }
        locations.didSet = { _ in update() }
        angle.didSet = { _ in update() }
        return self
    }
}
