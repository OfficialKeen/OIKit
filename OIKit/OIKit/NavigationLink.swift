//
//  NavigationLink.swift
//  OIKit
//
//  Created by keenoi on 22/01/24.
//

import UIKit


class NavigationLinkView: UIView {

    typealias Action = () -> Void

    private var action: Action?

    @discardableResult
    func content(_ action: @escaping Action, setup block: () -> Void) -> NavigationLinkView {
        block()
        self.action = action

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGesture)

        return self
    }

    @objc private func viewTapped() {
        action?()
    }

    func frame(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

