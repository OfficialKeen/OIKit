//
//  Padding.swift
//  OIKit
//
//  Created by keenoi on 22/01/24.
//

import UIKit

public enum Edge {
    case top, leading, trailing, bottom, vertical, horizontal, all
}

// MARK: UIStackView
extension UIStackView {
    @discardableResult
    public func padding(_ length: CGFloat = 8.0) -> UIStackView {
        let pads: [Edge] = [.all]
        for padding in pads {
            switch padding {
            case .top:
                self.layoutMargins.top = length
            case .leading:
                self.layoutMargins.left = length
            case .trailing:
                self.layoutMargins.right = length
            case .bottom:
                self.layoutMargins.bottom = length
            case .vertical:
                self.layoutMargins.top = length
                self.layoutMargins.bottom = length
            case .horizontal:
                self.layoutMargins.left = length
                self.layoutMargins.right = length
            case .all:
                self.layoutMargins = UIEdgeInsets(top: length, left: length, bottom: length, right: length)
            }
        }
        
        self.isLayoutMarginsRelativeArrangement = true
        return self
    }
    
    @discardableResult
    public func padding(_ edges: Edge, _ length: CGFloat = 8.0) -> UIStackView {
        switch edges {
        case .top:
            self.layoutMargins.top = length
        case .leading:
            self.layoutMargins.left = length
        case .trailing:
            self.layoutMargins.right = length
        case .bottom:
            self.layoutMargins.bottom = length
        case .vertical:
            self.layoutMargins.top = length
            self.layoutMargins.bottom = length
        case .horizontal:
            self.layoutMargins.left = length
            self.layoutMargins.right = length
        case .all:
            self.layoutMargins = UIEdgeInsets(top: length, left: length, bottom: length, right: length)
        }
        
        self.isLayoutMarginsRelativeArrangement = true
        return self
    }
    
    @discardableResult
    public func padding(_ edges: [Edge] = [.all], _ length: CGFloat = 8.0) -> UIStackView {
        for padding in edges {
            switch padding {
            case .top:
                self.layoutMargins.top = length
            case .leading:
                self.layoutMargins.left = length
            case .trailing:
                self.layoutMargins.right = length
            case .bottom:
                self.layoutMargins.bottom = length
            case .vertical:
                self.layoutMargins.top = length
                self.layoutMargins.bottom = length
            case .horizontal:
                self.layoutMargins.left = length
                self.layoutMargins.right = length
            case .all:
                self.layoutMargins = UIEdgeInsets(top: length, left: length, bottom: length, right: length)
            }
        }
        
        self.isLayoutMarginsRelativeArrangement = true
        return self
    }
}
