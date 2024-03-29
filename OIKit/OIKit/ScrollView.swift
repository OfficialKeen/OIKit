//
//  ScrollView.swift
//  OIKit
//
//  Created by keenoi on 22/01/24.
//

import UIKit

@resultBuilder
struct OIScrollViewBuilder {
    static func buildBlock(_ content: UIView) -> UIView {
        return content
    }
}

import UIKit

@resultBuilder
struct OIContentViewBuilder {
    static func buildBlock(_ content: UIView) -> UIView {
        return content
    }
}

extension UIView {
    @discardableResult
    func scrollViewContent(multiplier: CGFloat? = nil, isPaging: Bool = false, showIndicatorScroll: Bool = false, @OIContentViewBuilder content: (UIView) -> UIView) -> UIScrollView {
        let scrollView = UIScrollView()
        let contentView = content(UIView())
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        if showIndicatorScroll {
            scrollView.showsVerticalScrollIndicator = true
            scrollView.showsHorizontalScrollIndicator = true
        } else {
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
        }
        
        scrollView.isPagingEnabled = isPaging == false ? false : true
        
        if let multiplier = multiplier {
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: multiplier)
            ])
        } else {
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        }
        
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor)
        ])

        return scrollView
    }
}
