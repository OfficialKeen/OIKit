//
//  Segmented.swift
//  OIKit
//
//  Created by keenoi on 31/03/24.
//

import UIKit

extension UISegmentedControl {
    @discardableResult
    public func items(_ items: [String]) -> UISegmentedControl {
        removeAllSegments()
        for (index, title) in items.enumerated() {
            insertSegment(withTitle: title, at: index, animated: false)
        }
        return self
    }
    
    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> UISegmentedControl {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func setDefaultIndex(_ index: Int) -> UISegmentedControl {
        selectedSegmentIndex = index
        return self
    }
    
    @discardableResult
    public func selectedColor(hex: UInt) -> UISegmentedControl {
        if #available(iOS 13.0, *) {
            selectedSegmentTintColor = UIColor(hex: UInt32(hex))
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
    @discardableResult
    public func selectedColor(_ color: UIColor) -> UISegmentedControl {
        if #available(iOS 13.0, *) {
            selectedSegmentTintColor = color
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
    @discardableResult
    public func titleSelectColor(_ color: UIColor) -> UISegmentedControl {
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color], for: .selected)
        return self
    }
    
    @discardableResult
    public func titleUnselectColor(_ color: UIColor) -> UISegmentedControl {
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color], for: .normal)
        return self
    }
    
    @discardableResult
    public func foregroundColor(_ color: UIColor) -> UISegmentedControl {
        tintColor = color
        return self
    }
    
    @discardableResult
    public func isMomentary(_ value: Bool) -> UISegmentedControl {
        isMomentary = value
        return self
    }
    
    @discardableResult
    public func isEnabled(_ value: Bool) -> UISegmentedControl {
        isEnabled = value
        return self
    }
    
    @discardableResult
    public func apportionsSegmentWidthsByContent(_ value: Bool) -> UISegmentedControl {
        apportionsSegmentWidthsByContent = value
        return self
    }
    
    @discardableResult
    public func setSegmentTitle(_ title: String?, forSegmentAt segment: Int) -> UISegmentedControl {
        setTitle(title, forSegmentAt: segment)
        return self
    }
    
    @discardableResult
    public func setSegmentImage(_ image: UIImage?, forSegmentAt segment: Int) -> UISegmentedControl {
        setImage(image, forSegmentAt: segment)
        return self
    }
    
    @discardableResult
    public func setSegmentWidth(_ width: CGFloat, forSegmentAt segment: Int) -> UISegmentedControl {
        setWidth(width, forSegmentAt: segment)
        return self
    }
    
    @discardableResult
    public func onValueChanged(_ closure: @escaping (Int) -> Void) -> UISegmentedControl {
        addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        self.valueChangedClosure = closure
        
        return self
    }
    
    private var valueChangedClosure: ((Int) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.valueChangedClosure) as? (Int) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.valueChangedClosure, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc private func valueChanged(_ segmentedControl: UISegmentedControl) {
        valueChangedClosure?(segmentedControl.selectedSegmentIndex)
    }
}

private struct AssociatedKeys {
    static var valueChangedClosure: UInt8 = 0
}

