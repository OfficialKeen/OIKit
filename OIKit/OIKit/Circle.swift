//
//  Circle.swift
//  OIKit
//
//  Created by keenoi on 22/01/24.
//

import UIKit

class CircleView: UIView {
    var fillColor: UIColor = .clear {
        didSet {
            setNeedsDisplay()
        }
    }
    private var overlayView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
        layer.masksToBounds = true
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setFillColor(fillColor.cgColor)
        context.fillEllipse(in: rect)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2.0

        // Update the overlay's frame if it exists
        overlayView?.frame = bounds
    }
}

extension CircleView {
    @discardableResult
    public func fill(_ color: UIColor) -> CircleView {
        fillColor = color
        return self
    }
    
    @discardableResult
    public func shadow(color: UIColor, radius: CGFloat, opacity: Float, offset: CGSize) -> CircleView {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.masksToBounds = false
        return self
    }
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    @discardableResult
    public func stroke(_ color: UIColor? = .black, style: StrokeStyle) -> CircleView {
        let borderStyle = BorderStyle(style)
        layer.borderColor = color?.cgColor
        layer.borderWidth = style.lineWidth
        
        if let shapeLayer = layer as? CAShapeLayer {
            shapeLayer.lineDashPattern = borderStyle.lineDashPattern
            shapeLayer.lineCap = borderStyle.lineCap
            shapeLayer.lineJoin = borderStyle.lineJoin
        }
        
        return self
    }
}

struct StrokeStyle {
    var lineWidth: CGFloat = 1.0
    var lineDashPattern: [NSNumber]? = nil
    var lineCap: CAShapeLayerLineCap = .butt
    var lineJoin: CAShapeLayerLineJoin = .miter

    init(_ builder: (inout StrokeStyle) -> Void) {
        builder(&self)
    }
}

struct BorderStyle {
    let lineWidth: CGFloat
    let lineDashPattern: [NSNumber]?
    let lineCap: CAShapeLayerLineCap
    let lineJoin: CAShapeLayerLineJoin

    init(_ style: StrokeStyle) {
        self.lineWidth = style.lineWidth
        self.lineDashPattern = style.lineDashPattern
        self.lineCap = style.lineCap
        self.lineJoin = style.lineJoin
    }
}

