//
//  ProgressView.swift
//  OIKit
//
//  Created by keenoi on 15/05/24.
//

import UIKit

public extension UIProgressView {
    @discardableResult
    func onProgress(_ progress: Float, animated: Bool = true) -> UIProgressView {
        self.setProgress(progress, animated: animated)
        return self
    }
    
    @discardableResult
    func progressTintColor(_ color: UIColor) -> UIProgressView {
        self.progressTintColor = color
        return self
    }
    
    func progressTintColor(_ hex: UInt) -> UIProgressView {
        let color = UIColor(hex: UInt32(hex))
        self.progressTintColor = color
        return self
    }
    
    @discardableResult
    func trackTintColor(_ color: UIColor) -> UIProgressView {
        self.trackTintColor = color
        return self
    }
    
    func trackTintColor(_ hex: UInt) -> UIProgressView {
        let color = UIColor(hex: UInt32(hex))
        self.trackTintColor = color
        return self
    }
    
    @discardableResult
    func progressImage(_ image: UIImage?) -> UIProgressView {
        self.progressImage = image
        return self
    }
    
    @discardableResult
    func trackImage(_ image: UIImage?) -> UIProgressView {
        self.trackImage = image
        return self
    }
    
    @discardableResult
    func observedProgress(_ progress: Progress?) -> UIProgressView {
        self.observedProgress = progress
        return self
    }
    
    @discardableResult
    func progressViewStyle(_ style: UIProgressView.Style) -> UIProgressView {
        self.progressViewStyle = style
        return self
    }
}
