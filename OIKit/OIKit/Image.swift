//
//  Image.swift
//  OIKit
//
//  Created by keenoi on 22/01/24.
//

import UIKit

extension UIImageView {
    @discardableResult
    func image(_ name: String) -> Self {
        self.image = UIImage(named: name)
        return self
    }
    
    @discardableResult
    func image(systemName: String) -> Self {
        if #available(iOS 13.0, *) {
            self.image = UIImage(systemName: systemName)
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
    @discardableResult
    func renderingMode(_ renderingMode: UIImage.RenderingMode) -> Self {
        self.image = self.image?.withRenderingMode(renderingMode)
        return self
    }
    
    @discardableResult
    func foregroundColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    func foregroundColor(_ hex: UInt32) -> Self {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        self.tintColor = color
        return self
    }
    
    @discardableResult
    func resizable() -> Self {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        return self
    }
    
    @discardableResult
    func scaledToFill() -> Self {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        return self
    }
    
    @discardableResult
    func scaledToFit() -> Self {
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        return self
    }
    
    @discardableResult
    func clipped() -> Self {
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func aspectRatio(aspectRatio: CGSize? = nil, contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        self.clipsToBounds = true
        
        if let aspectRatio = aspectRatio, aspectRatio.width > 0, aspectRatio.height > 0 {
            self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: aspectRatio.width / aspectRatio.height).isActive = true
        } else if let aspectRatio = aspectRatio, aspectRatio.height > 0, aspectRatio.width > 0 {
            self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: aspectRatio.height / aspectRatio.width).isActive = true
        }
        
        return self
    }
    
    enum Alignment {
        case center
        case leading
        case trailing
    }
    
    @discardableResult
    func frame(width: CGFloat?, height: CGFloat?, alignment: Alignment? = nil) -> Self {
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let alignment = alignment {
            switch alignment {
            case .center:
                self.center = superview?.center ?? CGPoint.zero
            case .leading:
                self.frame.origin.x = 0
            case .trailing:
                if let superviewWidth = superview?.frame.width {
                    self.frame.origin.x = superviewWidth - self.frame.width
                }
            }
        }
        
        return self
    }
    
    @discardableResult
    func frame(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        minWidth: CGFloat? = nil,
        idealWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        idealHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        alignment: Alignment? = nil
    ) -> Self {
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let minWidth = minWidth {
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth).isActive = true
        }
        
        if let idealWidth = idealWidth {
            self.widthAnchor.constraint(equalToConstant: idealWidth).priority = .defaultHigh
        }
        
        if let maxWidth = maxWidth {
            self.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true
        }
        
        if let minHeight = minHeight {
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight).isActive = true
        }
        
        if let idealHeight = idealHeight {
            self.heightAnchor.constraint(equalToConstant: idealHeight).priority = .defaultHigh
        }
        
        if let maxHeight = maxHeight {
            self.heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight).isActive = true
        }
        
        if let alignment = alignment {
            switch alignment {
            case .center:
                self.center = superview?.center ?? CGPoint.zero
            case .leading:
                self.frame.origin.x = 0
            case .trailing:
                if let superviewWidth = superview?.frame.width {
                    self.frame.origin.x = superviewWidth - self.frame.width
                }
            }
        }
        
        return self
    }
}
