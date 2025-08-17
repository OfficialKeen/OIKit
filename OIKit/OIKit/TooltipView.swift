//
//  TooltipView.swift
//  OIKit
//
//  Created by keenoi on 17/08/25.
//

import UIKit

final class TooltipView: UIView {

    // MARK: - Properties
    private let text: String
    private let sourceView: UIView
    private let orientation: Orientation
    private let arrowSize = CGSize(width: 14, height: 8)
    private var arrowColor: UIColor = UIColor(white: 0.15, alpha: 0.9)
    private let contentBuilder: (() -> UIView)?

    enum Orientation { case top, bottom, left, right }

    // MARK: - UI
    private let label = UILabel()
    private let arrowLayer = CAShapeLayer()

    // MARK: - Init lama (label teks)
    init(text: String,
         sourceView: UIView,
         orientation: Orientation = .top) {
        self.text           = text
        self.sourceView     = sourceView
        self.orientation    = orientation
        self.contentBuilder = nil
        super.init(frame: .zero)
        setup()
    }

    // MARK: - Init baru (custom UIView)
    init(sourceView: UIView,
         orientation: Orientation = .top,
         contentBuilder: @escaping () -> UIView) {
        self.text            = ""
        self.sourceView      = sourceView
        self.orientation     = orientation
        self.contentBuilder  = contentBuilder
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Setup
    private func setup() {
        backgroundColor = UIColor(white: 0.15, alpha: 0.9)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false

        // MARK: - Content
        if let innerView = contentBuilder?() {
            let container = UIView()
            container.translatesAutoresizingMaskIntoConstraints = false
            innerView.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(innerView)

            let maxRatio: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 0.25 : 0.8
            let maxW = UIScreen.main.bounds.width * maxRatio - 24
            NSLayoutConstraint.activate([
                innerView.topAnchor     .constraint(equalTo: container.topAnchor),
                innerView.bottomAnchor  .constraint(equalTo: container.bottomAnchor),
                innerView.leadingAnchor .constraint(equalTo: container.leadingAnchor),
                innerView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                container.widthAnchor.constraint(lessThanOrEqualToConstant: maxW)
            ])

            addSubview(container)
            NSLayoutConstraint.activate([
                container.topAnchor    .constraint(equalTo: topAnchor,    constant: 8),
                container.bottomAnchor .constraint(equalTo: bottomAnchor, constant: -8),
                container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
            ])
            bringSubviewToFront(container)
        } else {
            label.textColor     = .white
            label.font          = .systemFont(ofSize: 12, weight: .regular)
            label.numberOfLines = 0
            label.text          = text
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)
            NSLayoutConstraint.activate([
                label.topAnchor    .constraint(equalTo: topAnchor,    constant: 8),
                label.bottomAnchor .constraint(equalTo: bottomAnchor, constant: -8),
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
            ])
            bringSubviewToFront(label)
        }

        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowRadius  = 6
        layer.shadowOpacity = 0.3
        layer.shadowOffset  = CGSize(width: 0, height: 2)

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSelf)))
        arrowLayer.fillColor = arrowColor.cgColor
        layer.addSublayer(arrowLayer)
    }

    // MARK: - Show
    func show(in container: UIView) {
        container.subviews
            .compactMap { $0 as? TooltipView }
            .forEach { $0.removeFromSuperview() }

        container.addSubview(self)
        container.layoutIfNeeded()
        translatesAutoresizingMaskIntoConstraints = true

        let maxRatio: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 0.5 : 0.8
        let maxWidth = min(UIScreen.main.bounds.width * maxRatio,
                           container.bounds.width - 32)
        label.preferredMaxLayoutWidth = maxWidth
        let size = systemLayoutSizeFitting(
            CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        )
        frame.size = size

        let sourceRect = sourceView.convert(sourceView.bounds, to: container)
        var x: CGFloat
        var y: CGFloat

        switch orientation {
        case .top:
            x = sourceRect.midX - size.width / 2
            y = sourceRect.minY - size.height - arrowSize.height
        case .bottom:
            x = sourceRect.midX - size.width / 2
            y = sourceRect.maxY + arrowSize.height
        case .left:
            x = sourceRect.minX - size.width - arrowSize.height
            y = sourceRect.midY - size.height / 2
            let minY: CGFloat = 16
            let maxY: CGFloat = container.bounds.height - size.height - 16
            y = max(minY, min(y, maxY))
        case .right:
            x = sourceRect.maxX + arrowSize.height
            y = sourceRect.midY - size.height / 2
            let minY: CGFloat = 16
            let maxY: CGFloat = container.bounds.height - size.height - 16
            y = max(minY, min(y, maxY))
        }

        x = max(16, min(x, container.bounds.width  - size.width  - 16))
        y = max(16, min(y, container.bounds.height - size.height - 16))
        frame.origin = CGPoint(x: x, y: y)

        drawArrow()

        alpha = 0
        transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
            self.transform = .identity
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.dismissSelf()
        }
    }

    // MARK: - Arrow (flexible)
    private func drawArrow() {
        guard let container = superview else { return }
        let sourceCenter = sourceView.convert(sourceView.bounds, to: container).center
        let arrowBase = convert(sourceCenter, from: container)

        let aw = arrowSize.width
        let ah = arrowSize.height
        let path = UIBezierPath()

        switch orientation {
        case .top:
            let x = max(aw/2, min(arrowBase.x, bounds.maxX - aw/2))
            path.move(to: CGPoint(x: x - aw/2, y: bounds.maxY))
            path.addLine(to: CGPoint(x: x, y: bounds.maxY + ah))
            path.addLine(to: CGPoint(x: x + aw/2, y: bounds.maxY))
        case .bottom:
            let x = max(aw/2, min(arrowBase.x, bounds.maxX - aw/2))
            path.move(to: CGPoint(x: x - aw/2, y: bounds.minY))
            path.addLine(to: CGPoint(x: x, y: bounds.minY - ah))
            path.addLine(to: CGPoint(x: x + aw/2, y: bounds.minY))
        case .left:
            let y = max(aw/2, min(arrowBase.y, bounds.maxY - aw/2))
            path.move(to: CGPoint(x: bounds.maxX, y: y - aw/2))
            path.addLine(to: CGPoint(x: bounds.maxX + ah, y: y))
            path.addLine(to: CGPoint(x: bounds.maxX, y: y + aw/2))
        case .right:
            let y = max(aw/2, min(arrowBase.y, bounds.maxY - aw/2))
            path.move(to: CGPoint(x: bounds.minX, y: y - aw/2))
            path.addLine(to: CGPoint(x: bounds.minX - ah, y: y))
            path.addLine(to: CGPoint(x: bounds.minX, y: y + aw/2))
        }
        path.close()
        arrowLayer.path = path.cgPath
    }

    @objc private func dismissSelf() {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: [.curveEaseIn, .allowUserInteraction],
                       animations: {
                           self.alpha = 0
                           self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                       }) { _ in
                           self.removeFromSuperview()
                       }
    }
    
    @discardableResult
    static func show(text: String,
                     sourceView: UIView,
                     orientation: Orientation = .top,
                     in container: UIView) -> TooltipView {
        let tip = TooltipView(text: text,
                              sourceView: sourceView,
                              orientation: orientation)
        tip.show(in: container)
        return tip
    }

    @discardableResult
    static func show(sourceView: UIView,
                     orientation: Orientation = .top,
                     in container: UIView,
                     contentBuilder: @escaping () -> UIView) -> TooltipView {
        let tip = TooltipView(sourceView: sourceView,
                              orientation: orientation,
                              contentBuilder: contentBuilder)
        tip.show(in: container)
        return tip
    }
}

extension TooltipView {
    @discardableResult
    public func foregroundColor(_ color: UIColor) -> Self {
        label.textColor = color
        return self
    }
    
    @discardableResult
    public func foregroundColor(_ hex: UInt) -> Self {
        let color = UIColor(hex: UInt32(hex))
        label.textColor = color
        return self
    }
    
    @discardableResult
    public func font(_ size: CGFloat, weight: UIFont.Weight = .regular, design: FontDesign = .default) -> Self {
        let traits: [UIFontDescriptor.TraitKey: Any] = [.weight: weight]

        let fontDescriptor = UIFontDescriptor(fontAttributes: [
            .family: design.fontName,
            .traits: traits
        ])

        label.font = UIFont(descriptor: fontDescriptor, size: size)
        return self
    }
    
    @discardableResult
    func background(_ color: UIColor) -> Self {
        backgroundColor = color
        
        arrowColor = color
        arrowLayer.fillColor = color.cgColor
        return self
    }
    
    @discardableResult
    public func background(_ hex: UInt) -> Self {
        let color = UIColor(hex: UInt32(hex))
        
        backgroundColor = color
        
        arrowColor = color
        arrowLayer.fillColor = color.cgColor
        return self
    }
    
    @discardableResult
    func background(_ color: UIColor, opacity: CGFloat = 1.0) -> Self {
        let final = color.withAlphaComponent(opacity)
        backgroundColor = final
        arrowLayer.fillColor = final.cgColor
        return self
    }
    
    @discardableResult
    func background(_ hex: UInt, opacity: CGFloat = 1.0) -> Self {
        let color = UIColor(hex: UInt32(hex)).withAlphaComponent(opacity)
        backgroundColor = color
        arrowLayer.fillColor = color.cgColor
        return self
    }
    
    @discardableResult
    func cornerRadius(_ radius: CGFloat = 10) -> Self {
        layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    public func stroke(_ color: UIColor? = .black, lineWidth: CGFloat? = 1) -> Self {
        self.layer.borderColor = color?.cgColor
        self.layer.borderWidth = lineWidth ?? 0
        return self
    }
    
    public func stroke(_ hexColor: UInt, lineWidth: CGFloat? = 1) -> Self {
        let color = UIColor(hex: UInt32(hexColor))
        return stroke(color, lineWidth: lineWidth)
    }
    
    @discardableResult
    public func shadow(color: UIColor, radius: CGFloat, opacity: Float, offset: CGSize) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.masksToBounds = false
        return self
    }
    
    @discardableResult
    public func shadow(color: UInt, radius: CGFloat, opacity: Float, offset: CGSize) -> Self {
        let hexColor = UIColor(hex: UInt32(color))
        layer.shadowColor = hexColor.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.masksToBounds = false
        return self
    }
    
    @discardableResult
    func arrowColor(_ color: UIColor) -> Self {
        arrowColor = color
        arrowLayer.fillColor = color.cgColor
        return self
    }
}

private extension CGRect {
    var center: CGPoint { CGPoint(x: midX, y: midY) }
}
