//
//  Label.swift
//  OIKit
//
//  Created by keenoi on 22/01/24.
//

import UIKit

public enum FontDesign {
    case `default`
    case monospaced
    case serif
    case rounded

    var fontName: String {
        switch self {
        case .default:
            return UIFont.systemFont(ofSize: 12).familyName
        case .monospaced:
            return "Courier New"
        case .serif:
            return "Times New Roman"
        case .rounded:
            return "Arial Rounded MT Bold"
        }
    }
}

extension UILabel {
    @discardableResult
    public func text(_ text: String) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    public func font(_ size: CGFloat, weight: UIFont.Weight = .regular, design: FontDesign = .default) -> Self {
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
    public func fontDesign(_ design: FontDesign) -> Self {
        return self.font(self.font?.pointSize ?? UIFont.systemFontSize, weight: .regular, design: design)
    }


    @discardableResult
    public func fontWeight(_ weight: UIFont.Weight) -> Self {
        let existingFont = self.font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.font = UIFont.systemFont(ofSize: existingFont.pointSize, weight: weight)
        return self
    }

    @discardableResult
    public func bold() -> Self {
        return fontWeight(.bold)
    }

    @discardableResult
    public func underline(_ isActive: Bool = true, color: UIColor? = nil) -> Self {
        if isActive {
            addUnderline(color: color)
        }
        return self
    }

    @discardableResult
    public func italic() -> Self {
        apply(style: .font, value: UIFont.italicSystemFont(ofSize: self.font?.pointSize ?? UIFont.systemFontSize))
        return self
    }

    @discardableResult
    public func strikethrough(_ isActive: Bool = true, color: UIColor? = nil) -> Self {
        if isActive {
            apply(style: .strikethroughStyle, value: NSUnderlineStyle.single.rawValue, color: color)
        }
        return self
    }

    @discardableResult
    public func foregroundColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    public func alignment(_ textAlignment: NSTextAlignment) -> Self {
        let container = UIView()
        container.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false

        switch textAlignment {
        case .left, .justified:
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        case .center:
            self.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        case .right:
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        case .natural:
            if UIView.userInterfaceLayoutDirection(for: container.semanticContentAttribute) == .leftToRight {
                self.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
            } else {
                self.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
            }
        @unknown default:
            break
        }

        return self
    }

    @discardableResult
    public func multilineTextAlignment(_ alignment: NSTextAlignment = .center) -> Self {
        self.textAlignment = alignment
        self.numberOfLines = 0
        return self
    }
    
    @discardableResult
    public func baselineOffset(_ baselineOffset: CGFloat) -> Self {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        attributedString.addAttribute(.baselineOffset, value: baselineOffset, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
        return self
    }
    
    @discardableResult
    public func kerning(_ kerning: CGFloat) -> Self {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        attributedString.addAttribute(.kern, value: kerning, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
        return self
    }
    
    private func addUnderline(color: UIColor? = nil) {
        guard let attributedText = self.attributedText else {
            return
        }

        let attributedString = NSMutableAttributedString(attributedString: attributedText)
        let range = NSRange(location: 0, length: attributedString.length)

        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)

        if let underlineColor = color {
            attributedString.addAttribute(.underlineColor, value: underlineColor, range: range)
        }

        self.attributedText = attributedString
    }

    private func apply(style: NSAttributedString.Key, value: Any, color: UIColor? = nil) {
        var attributes: [NSAttributedString.Key: Any] = [style: value]

        if let strikethroughColor = color {
            attributes[.strikethroughColor] = strikethroughColor
        }

        if let existingText = self.attributedText {
            let attributedString = NSMutableAttributedString(attributedString: existingText)
            attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        } else {
            self.attributedText = NSAttributedString(string: self.text ?? "", attributes: attributes)
        }
    }
}

