//
//  TextAttributeView.swift
//  OIKit
//
//  Created by Keen on 08/04/26.
//

import UIKit

// MARK: - Protocol

protocol TextAttributeItem {
    func build() -> NSAttributedString
}

// MARK: - Extend Existing Text (OIKit)

@available(iOS 13.0, *)
extension Text: TextAttributeItem {
    func build() -> NSAttributedString {
        let value = self.text ?? ""
        let font = self.font ?? UIFont.systemFont(ofSize: 14)
        let color = self.textColor ?? .label
        return NSAttributedString(
            string: value,
            attributes: [
                .font: font,
                .foregroundColor: color
            ]
        )
    }
}

// MARK: - Link Fragment

class TextLink: TextAttributeItem {
    
    private var value: String
    private var font: UIFont = .systemFont(ofSize: 14)
    private var color: UIColor = .systemBlue
    
    var action: (() -> Void)?
    
    init(_ text: String, action: (() -> Void)? = nil) {
        self.value = text
        self.action = action
    }
    
    @discardableResult
    func font(_ size: CGFloat, weight: UIFont.Weight = .regular) -> Self {
        self.font = .systemFont(ofSize: size, weight: weight)
        return self
    }
    
    @discardableResult
    func foregroundColor(_ color: UIColor) -> Self {
        self.color = color
        return self
    }
    
    @discardableResult
    func foregroundColor(_ hex: UInt) -> Self {
        self.color = UIColor(hex: UInt32(hex))
        return self
    }
    
    func build() -> NSAttributedString {
        
        return NSAttributedString(
            string: value,
            attributes: [
                .font: font,
                .foregroundColor: color,
                //.underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
    }
}

// MARK: - Image Fragment

@available(iOS 13.0, *)
class TextImage: TextAttributeItem {
    
    private var image: UIImage
    private var size: CGFloat = 16
    private var tintColor: UIColor?
    
    init(_ image: UIImage) {
        self.image = image
    }
    
    @discardableResult
    func size(_ size: CGFloat) -> Self {
        self.size = size
        return self
    }
    
    @discardableResult
    func foregroundColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    @discardableResult
    func foregroundColor(_ hex: UInt) -> Self {
        self.tintColor = UIColor(hex: UInt32(hex))
        return self
    }
    
    func build() -> NSAttributedString {
        let attachment = NSTextAttachment()
        var img = image
        if let tintColor {
            img = img.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        }
        attachment.image = img
        attachment.bounds = CGRect(
            x: 0,
            y: -3,
            width: size,
            height: size
        )
        return NSAttributedString(attachment: attachment)
    }
}

// MARK: - Builder

@resultBuilder
struct TextAttributeBuilder {
    static func buildBlock(_ components: TextAttributeItem...) -> [TextAttributeItem] {
        components
    }
}

// MARK: - UILabel Engine

class TextAttributeView: UILabel {
    private var linkRanges: [(NSRange, () -> Void)] = []
    init(@TextAttributeBuilder content: () -> [TextAttributeItem]) {
        super.init(frame: .zero)
        numberOfLines = 0
        isUserInteractionEnabled = true
        let items = content()
        let combined = NSMutableAttributedString()
        for item in items {
            let attr = item.build()
            let range = NSRange(
                location: combined.length,
                length: attr.length
            )
            combined.append(attr)
            if let link = item as? TextLink, let action = link.action {
                linkRanges.append((range, action))
            }
        }
        
        attributedText = combined
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let attributedText else { return }
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: bounds.size)
        let textStorage = NSTextStorage(attributedString: attributedText)
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = numberOfLines
        textContainer.lineBreakMode = lineBreakMode
        let location = gesture.location(in: self)
        
        let index = layoutManager.characterIndex(
            for: location,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )
        
        for (range, action) in linkRanges {
            if NSLocationInRange(index, range) {
                action()
                break
            }
        }
    }
}
