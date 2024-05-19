//
//  CollectionView.swift
//  OIKit
//
//  Created by keenoi on 31/03/24.
//

/*import UIKit

extension UICollectionView {
    public enum ScrollDirections {
        case vertical
        case horizontal
    }
    
    @discardableResult
    convenience init(direction: ScrollDirections) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = (direction == .vertical) ? .vertical : .horizontal
        self.init(frame: .zero, collectionViewLayout: layout)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.alwaysBounceVertical = false
        self.alwaysBounceHorizontal = false
        self.backgroundColor = .white
    }
    
    @discardableResult
    public func reload() -> UICollectionView {
        self.reloadData()
        return self
    }
    
    @discardableResult
    public func delegate(_ delegate: UICollectionViewDelegate) -> UICollectionView {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    public func dataSource(_ dataSource: UICollectionViewDataSource) -> UICollectionView {
        self.dataSource = dataSource
        return self
    }
    
    @discardableResult
    public func register(cell: AnyClass, id: String) -> UICollectionView {
        self.register(cell, forCellWithReuseIdentifier: id)
        return self
    }
    
    @discardableResult
    public func register(cell: AnyClass?, elementKind: String, id: String) -> UICollectionView {
        self.register(cell, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: id)
        return self
    }
    
    @discardableResult
    public func showsHorizontalScrollIndicator(_ value: Bool) -> UICollectionView {
        self.showsHorizontalScrollIndicator = value
        return self
    }
    
    @discardableResult
    public func showsVerticalScrollIndicator(_ value: Bool) -> UICollectionView {
        self.showsVerticalScrollIndicator = value
        return self
    }
    
    @discardableResult
    public func isScrollEnabled(_ value: Bool) -> UICollectionView {
        self.isScrollEnabled = value
        return self
    }
    
    @discardableResult
    public func allowsSelection(_ value: Bool) -> UICollectionView {
        self.allowsSelection = value
        return self
    }
    
    @discardableResult
    public func allowsMultipleSelection(_ value: Bool) -> UICollectionView {
        self.allowsMultipleSelection = value
        return self
    }
    
    @discardableResult
    public func contentInset(_ value: UIEdgeInsets) -> UICollectionView {
        self.contentInset = value
        return self
    }
    
    @discardableResult
    public func scrollIndicatorInsets(_ value: UIEdgeInsets) -> UICollectionView {
        self.scrollIndicatorInsets = value
        return self
    }
    
    @discardableResult
    public func alwaysBounceVertical(_ value: Bool) -> UICollectionView {
        self.alwaysBounceVertical = value
        return self
    }
    
    @discardableResult
    public func alwaysBounceHorizontal(_ value: Bool) -> UICollectionView {
        self.alwaysBounceHorizontal = value
        return self
    }
    
    @discardableResult
    public func contentSize(_ value: CGSize) -> UICollectionView {
        self.contentSize = value
        return self
    }
    
    @discardableResult
    public func contentOffset(_ value: CGPoint) -> UICollectionView {
        self.contentOffset = value
        return self
    }
    
    @discardableResult
    public func didSelectItemAt(_ closure: @escaping (UICollectionView, IndexPath) -> Void) -> UICollectionView {
        if #available(iOS 14.0, *) {
            self.selectionFollowsFocus = false
        }
        if #available(iOS 13.0, *) {
            _ = self.allowsSelection
        }
        self.delegate = self
        self.didSelectionHandler = closure // Adding selection handler closure
        return self
    }
    
    @discardableResult
    public func didDeselectItemAt(_ closure: @escaping (UICollectionView, IndexPath) -> Void) -> UICollectionView {
        self.delegate = self
        self.deselectionHandler = closure // Adding deselection handler closure
        return self
    }
    
    @discardableResult
    public func willDisplay(_ closure: @escaping (UICollectionView, UICollectionViewCell, IndexPath) -> Void) -> UICollectionView {
        self.delegate = self
        self.willDisplayHandler = closure // Adding willDisplay handler closure
        return self
    }
    
    @discardableResult
    public func didEndDisplaying(_ closure: @escaping (UICollectionView, UICollectionViewCell, IndexPath) -> Void) -> UICollectionView {
        self.delegate = self
        self.didEndDisplayingHandler = closure // Adding didEndDisplaying handler closure
        return self
    }
    
    @discardableResult
    public func didHighlightItemAt(_ closure: @escaping (UICollectionView, IndexPath) -> Void) -> UICollectionView {
        self.delegate = self
        self.didHighlightHandler = closure // Adding didHighlight handler closure
        return self
    }
    
    @discardableResult
    public func didUnhighlightItemAt(_ closure: @escaping (UICollectionView, IndexPath) -> Void) -> UICollectionView {
        self.delegate = self
        self.didUnhighlightHandler = closure // Adding didUnhighlight handler closure
        return self
    }
    
    private struct AssociatedKeys {
        // MARK: UICollectionViewDelegate
        static var didselectionHandler: UInt8 = 0
        static var deselectionHandler: UInt8 = 0
        static var willDisplayHandler: UInt8 = 0
        static var didEndDisplayingHandler: UInt8 = 0
        static var didHighlightHandler: UInt8 = 0
        static var didUnhighlightHandler: UInt8 = 0
        
        // MARK: UICollectionViewDelegateFlowLayout
        static var sizeForItemHandler: UInt8 = 0
        static var insetForSectionHandler: UInt8 = 0
        static var minimumLineSpacingForSectionHandler: UInt8 = 0
        static var minimumInteritemSpacingForSectionHandler: UInt8 = 0

        static var viewForSupplementaryElementHandler: UInt8 = 0
        static var referenceSizeForHeaderInSectionHandler: UInt8 = 0
    }
}

extension UICollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Calling the selection handler closure if it's set
        didSelectionHandler?(collectionView, indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // Calling the deselection handler closure if it's set
        deselectionHandler?(collectionView, indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Calling the willDisplay handler closure if it's set
        willDisplayHandler?(collectionView, cell, indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Calling the didEndDisplaying handler closure if it's set
        didEndDisplayingHandler?(collectionView, cell, indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        // Calling the didHighlight handler closure if it's set
        didHighlightHandler?(collectionView, indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        // Calling the didUnhighlight handler closure if it's set
        didUnhighlightHandler?(collectionView, indexPath)
    }
}

extension UICollectionView {
    @discardableResult
    public func sizeForItemAt(_ closure: @escaping (UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize) -> UICollectionView {
        self.delegate = self
        self.sizeForItemHandler = closure // Adding sizeForItemAt handler closure
        return self
    }
    
    @discardableResult
    public func insetForSectionAt(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets) -> UICollectionView {
        self.delegate = self
        self.insetForSectionHandler = closure // Adding insetForSectionAt handler closure
        return self
    }
    
    @discardableResult
    public func spacingCell(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGFloat) -> UICollectionView {
        self.delegate = self
        self.minimumLineSpacingForSectionHandler = closure // Adding minimumLineSpacingForSectionAt handler closure
        return self
    }
    
    @discardableResult
    public func minimumLineSpacingForSectionAt(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGFloat) -> UICollectionView {
        self.delegate = self
        self.minimumLineSpacingForSectionHandler = closure // Adding minimumLineSpacingForSectionAt handler closure
        return self
    }
    
    @discardableResult
    public func minimumInteritemSpacingForSectionAt(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGFloat) -> UICollectionView {
        self.delegate = self
        self.minimumInteritemSpacingForSectionHandler = closure // Adding minimumInteritemSpacingForSectionAt handler closure
        return self
    }
}

extension UICollectionView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calling the sizeForItemAt handler closure if it's set
        return sizeForItemHandler?(collectionView, collectionViewLayout, indexPath) ?? CGSize(width: 50, height: 50) // Default size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insetForSectionHandler?(collectionView, collectionViewLayout, section) ?? UIEdgeInsets.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacingForSectionHandler?(collectionView, collectionViewLayout, section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacingForSectionHandler?(collectionView, collectionViewLayout, section) ?? 0
    }
}

extension UICollectionView {
    private var didSelectionHandler: ((UICollectionView, IndexPath) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didselectionHandler) as? (UICollectionView, IndexPath) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.didselectionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var deselectionHandler: ((UICollectionView, IndexPath) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.deselectionHandler) as? (UICollectionView, IndexPath) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.deselectionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var willDisplayHandler: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.willDisplayHandler) as? (UICollectionView, UICollectionViewCell, IndexPath) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.willDisplayHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var didEndDisplayingHandler: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didEndDisplayingHandler) as? (UICollectionView, UICollectionViewCell, IndexPath) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.didEndDisplayingHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var didHighlightHandler: ((UICollectionView, IndexPath) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didHighlightHandler) as? (UICollectionView, IndexPath) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.didHighlightHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var didUnhighlightHandler: ((UICollectionView, IndexPath) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didUnhighlightHandler) as? (UICollectionView, IndexPath) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.didUnhighlightHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var sizeForItemHandler: ((UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.sizeForItemHandler) as? (UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.sizeForItemHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var insetForSectionHandler: ((UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.insetForSectionHandler) as? (UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.insetForSectionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var minimumLineSpacingForSectionHandler: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.minimumLineSpacingForSectionHandler) as? (UICollectionView, UICollectionViewLayout, Int) -> CGFloat
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.minimumLineSpacingForSectionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var minimumInteritemSpacingForSectionHandler: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.minimumInteritemSpacingForSectionHandler) as? (UICollectionView, UICollectionViewLayout, Int) -> CGFloat
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.minimumInteritemSpacingForSectionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UICollectionView {
    @discardableResult
    public func referenceSizeForHeaderInSection(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGSize) -> UICollectionView {
        self.delegate = self
        self.referenceSizeForHeaderInSectionHandler = closure // Adding referenceSizeForHeaderInSection handler closure
        return self
    }
    
    @discardableResult
    public func viewForSupplementaryElementOfKind(_ closure: @escaping (UICollectionView, String, IndexPath) -> UICollectionReusableView) -> UICollectionView {
        self.delegate = self
        self.viewForSupplementaryElementHandler = closure // Adding viewForSupplementaryElementOfKind handler closure
        return self
    }
}

extension UICollectionView {
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return viewForSupplementaryElementHandler?(collectionView, kind, indexPath) ?? UICollectionReusableView()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return referenceSizeForHeaderInSectionHandler?(collectionView, collectionViewLayout, section) ?? CGSize.zero
        }
    
    private var referenceSizeForHeaderInSectionHandler: ((UICollectionView, UICollectionViewLayout, Int) -> CGSize)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.referenceSizeForHeaderInSectionHandler) as? (UICollectionView, UICollectionViewLayout, Int) -> CGSize
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.referenceSizeForHeaderInSectionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var viewForSupplementaryElementHandler: ((UICollectionView, String, IndexPath) -> UICollectionReusableView)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.viewForSupplementaryElementHandler) as? (UICollectionView, String, IndexPath) -> UICollectionReusableView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.viewForSupplementaryElementHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


extension UICollectionView {
    public func dequeueView<T: UICollectionReusableView>(ofKind kind: String, identifier id: String, for indexPath: IndexPath) -> T {
        guard let view = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(T.self) with identifier: \(id)")
        }
        return view
    }
    
    public func infinitySize(_ headerFooterView: UICollectionReusableView) -> CGSize {
        let fittingSize = CGSize(width: self.frame.width, height: UIView.layoutFittingCompressedSize.height)
        return headerFooterView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}

extension UICollectionView {
    public func dequeueCell<T: UICollectionViewCell>(id: String, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(T.self) with identifier: \(id)")
        }
        return cell
    }
}*/

import UIKit

public class Collection: UICollectionView {

    public enum ScrollDirections {
        case vertical
        case horizontal
    }

    @discardableResult
    convenience init(direction: ScrollDirections) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = (direction == .vertical) ? .vertical : .horizontal
        self.init(frame: .zero, collectionViewLayout: layout)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.alwaysBounceVertical = false
        self.alwaysBounceHorizontal = false
        self.backgroundColor = .white
    }
    
    @discardableResult
    func isHidden(_ bool: Bool = true) -> Self {
        self.isHidden = bool
        return self
    }
    
    @discardableResult
    func isHidden(_ state: SBinding<Bool>) -> Self {
        self.isHidden = state.wrappedValue
        state.didSet = { [weak self] newValue in
            self?.isHidden = newValue
        }
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat) -> Self {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func height(_ height: CGFloat) -> Self {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }

    @discardableResult
    func reload() -> Collection {
        self.reloadData()
        return self
    }

    @discardableResult
    func delegate(_ delegate: UICollectionViewDelegate) -> Collection {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func dataSource(_ dataSource: UICollectionViewDataSource) -> Collection {
        self.dataSource = dataSource
        return self
    }

    @discardableResult
    func register(cell: AnyClass, id: String) -> Collection {
        self.register(cell, forCellWithReuseIdentifier: id)
        return self
    }

    @discardableResult
    func register(cell: AnyClass?, elementKind: String, id: String) -> Collection {
        self.register(cell, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: id)
        return self
    }

    @discardableResult
    func showsHorizontalScrollIndicator(_ value: Bool) -> Collection {
        self.showsHorizontalScrollIndicator = value
        return self
    }

    @discardableResult
    func showsVerticalScrollIndicator(_ value: Bool) -> Collection {
        self.showsVerticalScrollIndicator = value
        return self
    }

    @discardableResult
    func isScrollEnabled(_ value: Bool) -> Collection {
        self.isScrollEnabled = value
        return self
    }

    @discardableResult
    func allowsSelection(_ value: Bool) -> Collection {
        self.allowsSelection = value
        return self
    }

    @discardableResult
    func allowsMultipleSelection(_ value: Bool) -> Collection {
        self.allowsMultipleSelection = value
        return self
    }

    @discardableResult
    func contentInset(_ value: UIEdgeInsets) -> Collection {
        self.contentInset = value
        return self
    }

    @discardableResult
    func scrollIndicatorInsets(_ value: UIEdgeInsets) -> Collection {
        self.scrollIndicatorInsets = value
        return self
    }

    @discardableResult
    func alwaysBounceVertical(_ value: Bool) -> Collection {
        self.alwaysBounceVertical = value
        return self
    }

    @discardableResult
    func alwaysBounceHorizontal(_ value: Bool) -> Collection {
        self.alwaysBounceHorizontal = value
        return self
    }

    @discardableResult
    func contentSize(_ value: CGSize) -> Collection {
        self.contentSize = value
        return self
    }

    @discardableResult
    func contentOffset(_ value: CGPoint) -> Collection {
        self.contentOffset = value
        return self
    }

    @discardableResult
    func didSelectItemAt(_ closure: @escaping (UICollectionView, IndexPath) -> Void) -> Collection {
        if #available(iOS 14.0, *) {
            self.selectionFollowsFocus = false
        }
        if #available(iOS 13.0, *) {
            _ = self.allowsSelection
        }
        self.delegate = self
        self.didSelectionHandler = closure // Adding selection handler closure
        return self
    }

    @discardableResult
    func didDeselectItemAt(_ closure: @escaping (UICollectionView, IndexPath) -> Void) -> Collection {
        self.delegate = self
        self.deselectionHandler = closure // Adding deselection handler closure
        return self
    }

    @discardableResult
    func willDisplay(_ closure: @escaping (UICollectionView, UICollectionViewCell, IndexPath) -> Void) -> Collection {
        self.delegate = self
        self.willDisplayHandler = closure // Adding willDisplay handler closure
        return self
    }

    @discardableResult
    func didEndDisplaying(_ closure: @escaping (UICollectionView, UICollectionViewCell, IndexPath) -> Void) -> Collection {
        self.delegate = self
        self.didEndDisplayingHandler = closure // Adding didEndDisplaying handler closure
        return self
    }

    @discardableResult
    func didHighlightItemAt(_ closure: @escaping (UICollectionView, IndexPath) -> Void) -> Collection {
        self.delegate = self
        self.didHighlightHandler = closure // Adding didHighlight handler closure
        return self
    }

    @discardableResult
    func didUnhighlightItemAt(_ closure: @escaping (UICollectionView, IndexPath) -> Void) -> Collection {
        self.delegate = self
        self.didUnhighlightHandler = closure // Adding didUnhighlight handler closure
        return self
    }

    @discardableResult
    func sizeForItemAt(_ closure: @escaping (UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize) -> Collection {
        self.delegate = self
        self.sizeForItemHandler = closure // Adding sizeForItemAt handler closure
        return self
    }

    @discardableResult
    func insetForSectionAt(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets) -> Collection {
        self.delegate = self
        self.insetForSectionHandler = closure // Adding insetForSectionAt handler closure
        return self
    }

    @discardableResult
    func spacingCell(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGFloat) -> Collection {
        self.delegate = self
        self.minimumLineSpacingForSectionHandler = closure // Adding minimumLineSpacingForSectionAt handler closure
        return self
    }

    @discardableResult
    func minimumLineSpacingForSectionAt(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGFloat) -> Collection {
        self.delegate = self
        self.minimumLineSpacingForSectionHandler = closure // Adding minimumLineSpacingForSectionAt handler closure
        return self
    }

    @discardableResult
    func minimumInteritemSpacingForSectionAt(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGFloat) -> Collection {
        self.delegate = self
        self.minimumInteritemSpacingForSectionHandler = closure // Adding minimumInteritemSpacingForSectionAt handler closure
        return self
    }

    @discardableResult
    func referenceSizeForHeaderInSection(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGSize) -> Collection {
        self.delegate = self
        self.referenceSizeForHeaderInSectionHandler = closure // Adding referenceSizeForHeaderInSection handler closure
        return self
    }

    @discardableResult
    func viewForSupplementaryElementOfKind(_ closure: @escaping (UICollectionView, String, IndexPath) -> UICollectionReusableView) -> Collection {
        self.delegate = self
        self.viewForSupplementaryElementHandler = closure // Adding viewForSupplementaryElementOfKind handler closure
        return self
    }

    // Define associated object keys
    private struct AssociatedKeys {
        static var didselectionHandler: UInt8 = 0
        static var deselectionHandler: UInt8 = 0
        static var willDisplayHandler: UInt8 = 0
        static var didEndDisplayingHandler: UInt8 = 0
        static var didHighlightHandler: UInt8 = 0
        static var didUnhighlightHandler: UInt8 = 0
        static var sizeForItemHandler: UInt8 = 0
        static var insetForSectionHandler: UInt8 = 0
        static var minimumLineSpacingForSectionHandler: UInt8 = 0
        static var minimumInteritemSpacingForSectionHandler: UInt8 = 0
        static var referenceSizeForHeaderInSectionHandler: UInt8 = 0
        static var viewForSupplementaryElementHandler: UInt8 = 0
    }

    // Define associated object properties
    private var didSelectionHandler: ((UICollectionView, IndexPath) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didselectionHandler) as? (UICollectionView, IndexPath) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.didselectionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var deselectionHandler: ((UICollectionView, IndexPath) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.deselectionHandler) as? (UICollectionView, IndexPath) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.deselectionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var willDisplayHandler: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.willDisplayHandler) as? (UICollectionView, UICollectionViewCell, IndexPath) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.willDisplayHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var didEndDisplayingHandler: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didEndDisplayingHandler) as? (UICollectionView, UICollectionViewCell, IndexPath) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.didEndDisplayingHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var didHighlightHandler: ((UICollectionView, IndexPath) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didHighlightHandler) as? (UICollectionView, IndexPath) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.didHighlightHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var didUnhighlightHandler: ((UICollectionView, IndexPath) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didUnhighlightHandler) as? (UICollectionView, IndexPath) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.didUnhighlightHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var sizeForItemHandler: ((UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.sizeForItemHandler) as? (UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.sizeForItemHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var insetForSectionHandler: ((UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.insetForSectionHandler) as? (UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.insetForSectionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var minimumLineSpacingForSectionHandler: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.minimumLineSpacingForSectionHandler) as? (UICollectionView, UICollectionViewLayout, Int) -> CGFloat
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.minimumLineSpacingForSectionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var minimumInteritemSpacingForSectionHandler: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.minimumInteritemSpacingForSectionHandler) as? (UICollectionView, UICollectionViewLayout, Int) -> CGFloat
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.minimumInteritemSpacingForSectionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var referenceSizeForHeaderInSectionHandler: ((UICollectionView, UICollectionViewLayout, Int) -> CGSize)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.referenceSizeForHeaderInSectionHandler) as? (UICollectionView, UICollectionViewLayout, Int) -> CGSize
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.referenceSizeForHeaderInSectionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var viewForSupplementaryElementHandler: ((UICollectionView, String, IndexPath) -> UICollectionReusableView)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.viewForSupplementaryElementHandler) as? (UICollectionView, String, IndexPath) -> UICollectionReusableView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.viewForSupplementaryElementHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// Conforming to UICollectionViewDelegateFlowLayout
extension Collection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectionHandler?(collectionView, indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.deselectionHandler?(collectionView, indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.willDisplayHandler?(collectionView, cell, indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.didEndDisplayingHandler?(collectionView, cell, indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        self.didHighlightHandler?(collectionView, indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        self.didUnhighlightHandler?(collectionView, indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.sizeForItemHandler?(collectionView, collectionViewLayout, indexPath) ?? CGSize.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.insetForSectionHandler?(collectionView, collectionViewLayout, section) ?? UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.minimumLineSpacingForSectionHandler?(collectionView, collectionViewLayout, section) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.minimumInteritemSpacingForSectionHandler?(collectionView, collectionViewLayout, section) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return self.referenceSizeForHeaderInSectionHandler?(collectionView, collectionViewLayout, section) ?? CGSize.zero
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return self.viewForSupplementaryElementHandler?(collectionView, kind, indexPath) ?? UICollectionReusableView()
    }
}
