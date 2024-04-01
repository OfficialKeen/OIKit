//
//  TextView.swift
//  OIKit
//
//  Created by keenoi on 01/04/24.
//

import UIKit

extension UITextView {
    @discardableResult
    public func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    public func foregroundColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    public func font(_ size: CGFloat = 16, weight: UIFont.Weight = .regular, design: FontDesign = .default) -> Self {
        let traits: [UIFontDescriptor.TraitKey: Any] = [.weight: weight]

        let fontDescriptor = UIFontDescriptor(fontAttributes: [
            .family: design.fontName,
            .traits: traits
        ])

        self.font = UIFont(descriptor: fontDescriptor, size: size)
        return self
    }

    @discardableResult
    public func font(_ style: UIFont.TextStyle) -> Self {
        self.font = UIFont.preferredFont(forTextStyle: style)
        return self
    }
    
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func padding(_ value: CGFloat) -> Self {
        let insets = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
        self.textContainerInset = insets
        return self
    }
    
    private var placeholderLabel: UILabel? {
        return self.viewWithTag(100) as? UILabel
    }
    
    @discardableResult
    func placeholder(_ text: String, fontSize: CGFloat? = nil, font: UIFont? = nil, position: CGPoint) -> Self {
        let placeholderLabel = UILabel()
        placeholderLabel.font = font ?? self.font // Gunakan font default jika tidak diberikan
        placeholderLabel.textColor = UIColor.purple
        placeholderLabel.text = text
        placeholderLabel.font = placeholderLabel.font.withSize(fontSize ?? 16) // Gunakan ukuran font default 17 jika tidak diberikan
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin = position // Mengatur posisi placeholder sesuai parameter
        placeholderLabel.tag = 100 // for accessing the placeholder label later
        self.addSubview(placeholderLabel)
        
        // Menambahkan observer untuk notifikasi ketika teks berubah
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)
        
        return self
    }
    
    @objc private func textDidChange() {
        // Sembunyikan placeholder jika terdapat teks
        placeholderLabel?.isHidden = !self.text.isEmpty
    }
}

