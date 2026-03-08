//
//  Collection.swift
//  OIKit
//
//  Created by keenoi on 31/03/24.
//

import UIKit

public class Collection: UICollectionView {
    
    public enum ScrollDirection {
        case vertical
        case horizontal
    }
    
    public convenience init(direction: ScrollDirection) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction == .vertical ? .vertical : .horizontal
        
        self.init(frame: .zero, collectionViewLayout: layout)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        alwaysBounceVertical = false
        alwaysBounceHorizontal = false
        backgroundColor = .white
    }
    
    @discardableResult
    public func isHidden(_ bool: Bool = true) -> Self {
        self.isHidden = bool
        return self
    }
    
    @discardableResult
    public func isHidden(_ state: SBinding<Bool>) -> Self {
        self.isHidden = state.wrappedValue
        state.didSet = { [weak self] newValue in
            self?.isHidden = newValue
        }
        return self
    }
    
    @discardableResult
    public func width(_ width: CGFloat) -> Self {
        
        self.constraints
            .filter { $0.firstAttribute == .width }
            .forEach { $0.isActive = false }
        
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    public func height(_ height: CGFloat) -> Self {
        
        self.constraints
            .filter { $0.firstAttribute == .height }
            .forEach { $0.isActive = false }
        
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    public func reload() -> Self {
        self.reloadData()
        return self
    }
    
    @discardableResult
    public func delegate(_ delegate: UICollectionViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    public func dataSource(_ dataSource: UICollectionViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }
    
    @discardableResult
    public func register(cell: AnyClass, id: String) -> Self {
        self.register(cell, forCellWithReuseIdentifier: id)
        return self
    }
    
    @discardableResult
    public func register(cell: AnyClass?, elementKind: String, id: String) -> Self {
        self.register(cell, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: id)
        return self
    }
    
    @discardableResult
    public func showsHorizontalScrollIndicator(_ value: Bool) -> Self {
        self.showsHorizontalScrollIndicator = value
        return self
    }
    
    @discardableResult
    public func showsVerticalScrollIndicator(_ value: Bool) -> Self {
        self.showsVerticalScrollIndicator = value
        return self
    }
    
    @discardableResult
    public func isScrollEnabled(_ value: Bool) -> Self {
        self.isScrollEnabled = value
        return self
    }
    
    @discardableResult
    public func allowsSelection(_ value: Bool) -> Self {
        self.allowsSelection = value
        return self
    }
    
    @discardableResult
    public func allowsMultipleSelection(_ value: Bool) -> Self {
        self.allowsMultipleSelection = value
        return self
    }
    
    @discardableResult
    public func contentInset(_ value: UIEdgeInsets) -> Self {
        self.contentInset = value
        return self
    }
    
    @discardableResult
    public func scrollIndicatorInsets(_ value: UIEdgeInsets) -> Self {
        self.scrollIndicatorInsets = value
        return self
    }
    
    @discardableResult
    public func alwaysBounceVertical(_ value: Bool) -> Self {
        self.alwaysBounceVertical = value
        return self
    }
    
    @discardableResult
    public func alwaysBounceHorizontal(_ value: Bool) -> Self {
        self.alwaysBounceHorizontal = value
        return self
    }
    
    @discardableResult
    public func contentSize(_ value: CGSize) -> Self {
        self.contentSize = value
        return self
    }
    
    @discardableResult
    public func contentOffset(_ value: CGPoint) -> Self {
        self.contentOffset = value
        return self
    }
    
    private func ensureSelfDelegate() {
        if self.delegate == nil || self.delegate === self {
            self.delegate = self
        }
    }
    
    @discardableResult
    public func didSelectItemAt(_ closure: @escaping (UICollectionView, IndexPath) -> Void) -> Self {
        
        if #available(iOS 14.0, *) {
            self.selectionFollowsFocus = false
        }
        
        ensureSelfDelegate()
        
        self.didSelectionHandler = closure
        return self
    }
    
    @discardableResult
    public func didDeselectItemAt(_ closure: @escaping (UICollectionView, IndexPath) -> Void) -> Self {
        ensureSelfDelegate()
        self.deselectionHandler = closure
        return self
    }
    
    @discardableResult
    public func willDisplay(_ closure: @escaping (UICollectionView, UICollectionViewCell, IndexPath) -> Void) -> Self {
        ensureSelfDelegate()
        self.willDisplayHandler = closure
        return self
    }
    
    @discardableResult
    public func didEndDisplaying(_ closure: @escaping (UICollectionView, UICollectionViewCell, IndexPath) -> Void) -> Self {
        ensureSelfDelegate()
        self.didEndDisplayingHandler = closure
        return self
    }
    
    @discardableResult
    public func didHighlightItemAt(_ closure: @escaping (UICollectionView, IndexPath) -> Void) -> Self {
        ensureSelfDelegate()
        self.didHighlightHandler = closure
        return self
    }
    
    @discardableResult
    public func didUnhighlightItemAt(_ closure: @escaping (UICollectionView, IndexPath) -> Void) -> Self {
        ensureSelfDelegate()
        self.didUnhighlightHandler = closure
        return self
    }
    
    @discardableResult
    public func sizeForItemAt(_ closure: @escaping (UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize) -> Self {
        ensureSelfDelegate()
        self.sizeForItemHandler = closure
        return self
    }
    
    @discardableResult
    public func insetForSectionAt(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets) -> Self {
        ensureSelfDelegate()
        self.insetForSectionHandler = closure
        return self
    }
    
    @discardableResult
    public func spacingCell(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGFloat) -> Self {
        ensureSelfDelegate()
        self.minimumLineSpacingForSectionHandler = closure
        return self
    }
    
    @discardableResult
    public func minimumLineSpacingForSectionAt(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGFloat) -> Self {
        ensureSelfDelegate()
        self.minimumLineSpacingForSectionHandler = closure
        return self
    }
    
    @discardableResult
    public func minimumInteritemSpacingForSectionAt(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGFloat) -> Self {
        ensureSelfDelegate()
        self.minimumInteritemSpacingForSectionHandler = closure
        return self
    }
    
    @discardableResult
    public func referenceSizeForHeaderInSection(_ closure: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGSize) -> Self {
        ensureSelfDelegate()
        self.referenceSizeForHeaderInSectionHandler = closure
        return self
    }
    
    @discardableResult
    public func viewForSupplementaryElementOfKind(_ closure: @escaping (UICollectionView, String, IndexPath) -> UICollectionReusableView) -> Self {
        ensureSelfDelegate()
        self.viewForSupplementaryElementHandler = closure
        return self
    }
    
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
        static var gridConfigs: UInt8 = 0
    }
    
    private var didSelectionHandler: ((UICollectionView, IndexPath) -> Void)? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.didselectionHandler) as? (UICollectionView, IndexPath) -> Void }
        set { objc_setAssociatedObject(self, &AssociatedKeys.didselectionHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    private var deselectionHandler: ((UICollectionView, IndexPath) -> Void)? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.deselectionHandler) as? (UICollectionView, IndexPath) -> Void }
        set { objc_setAssociatedObject(self, &AssociatedKeys.deselectionHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    private var willDisplayHandler: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.willDisplayHandler) as? (UICollectionView, UICollectionViewCell, IndexPath) -> Void }
        set { objc_setAssociatedObject(self, &AssociatedKeys.willDisplayHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    private var didEndDisplayingHandler: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.didEndDisplayingHandler) as? (UICollectionView, UICollectionViewCell, IndexPath) -> Void }
        set { objc_setAssociatedObject(self, &AssociatedKeys.didEndDisplayingHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    private var didHighlightHandler: ((UICollectionView, IndexPath) -> Void)? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.didHighlightHandler) as? (UICollectionView, IndexPath) -> Void }
        set { objc_setAssociatedObject(self, &AssociatedKeys.didHighlightHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    private var didUnhighlightHandler: ((UICollectionView, IndexPath) -> Void)? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.didUnhighlightHandler) as? (UICollectionView, IndexPath) -> Void }
        set { objc_setAssociatedObject(self, &AssociatedKeys.didUnhighlightHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    private var sizeForItemHandler: ((UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize)? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.sizeForItemHandler) as? (UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize }
        set { objc_setAssociatedObject(self, &AssociatedKeys.sizeForItemHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    private var insetForSectionHandler: ((UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets)? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.insetForSectionHandler) as? (UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets }
        set { objc_setAssociatedObject(self, &AssociatedKeys.insetForSectionHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    private var minimumLineSpacingForSectionHandler: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.minimumLineSpacingForSectionHandler) as? (UICollectionView, UICollectionViewLayout, Int) -> CGFloat }
        set { objc_setAssociatedObject(self, &AssociatedKeys.minimumLineSpacingForSectionHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    private var minimumInteritemSpacingForSectionHandler: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.minimumInteritemSpacingForSectionHandler) as? (UICollectionView, UICollectionViewLayout, Int) -> CGFloat }
        set { objc_setAssociatedObject(self, &AssociatedKeys.minimumInteritemSpacingForSectionHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    private var referenceSizeForHeaderInSectionHandler: ((UICollectionView, UICollectionViewLayout, Int) -> CGSize)? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.referenceSizeForHeaderInSectionHandler) as? (UICollectionView, UICollectionViewLayout, Int) -> CGSize }
        set { objc_setAssociatedObject(self, &AssociatedKeys.referenceSizeForHeaderInSectionHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    private var viewForSupplementaryElementHandler: ((UICollectionView, String, IndexPath) -> UICollectionReusableView)? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.viewForSupplementaryElementHandler) as? (UICollectionView, String, IndexPath) -> UICollectionReusableView }
        set { objc_setAssociatedObject(self, &AssociatedKeys.viewForSupplementaryElementHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    private var gridConfigs: [Int: GridConfig] {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.gridConfigs) as? [Int: GridConfig] ?? [:] }
        set { objc_setAssociatedObject(self, &AssociatedKeys.gridConfigs, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }
}

extension Collection: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectionHandler?(collectionView, indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        deselectionHandler?(collectionView, indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplayHandler?(collectionView, cell, indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        didEndDisplayingHandler?(collectionView, cell, indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        didHighlightHandler?(collectionView, indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        didUnhighlightHandler?(collectionView, indexPath)
    }
    
    /*public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     sizeForItemHandler?(collectionView, collectionViewLayout, indexPath) ?? CGSize.zero
     }*/
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let handler = sizeForItemHandler {
            return handler(collectionView, collectionViewLayout, indexPath)
        }
        
        guard let config = gridConfigs[indexPath.section] else {
            return CGSize(width: collectionView.bounds.width, height: 50)
        }
        
        let inset = config.inset
        let spacing = config.spacing
        let containerWidth = collectionView.bounds.width - inset.left - inset.right
        
        switch config.style {
            
        case .fixed(let columns):
            
            let safeColumns = max(columns, 1)
            let totalSpacing = CGFloat(safeColumns - 1) * spacing
            let width = floor((containerWidth - totalSpacing) / CGFloat(safeColumns))
            
            return CGSize(width: width, height: config.height ?? width)
            
        case .flexible(let columns):
            
            let safeColumns = max(columns, 1)
            let totalSpacing = CGFloat(safeColumns - 1) * spacing
            let width = floor((containerWidth - totalSpacing) / CGFloat(safeColumns))
            
            return CGSize(width: width, height: config.height ?? width * 0.75)
            
        case .adaptive(let minWidth):
            
            let columns = max(1, Int(containerWidth / minWidth))
            let totalSpacing = CGFloat(columns - 1) * spacing
            let width = floor((containerWidth - totalSpacing) / CGFloat(columns))
            
            return CGSize(width: width, height: config.height ?? width)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        insetForSectionHandler?(collectionView, collectionViewLayout, section) ?? .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        minimumLineSpacingForSectionHandler?(collectionView, collectionViewLayout, section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        minimumInteritemSpacingForSectionHandler?(collectionView, collectionViewLayout, section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        referenceSizeForHeaderInSectionHandler?(collectionView, collectionViewLayout, section) ?? .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        viewForSupplementaryElementHandler?(collectionView, kind, indexPath) ?? UICollectionReusableView()
    }
}

public enum GridStyle {
    case fixed(Int)
    case flexible(Int)
    case adaptive(minWidth: CGFloat)
}

extension Collection {
    
    @discardableResult
    public func grid(
        _ style: GridStyle,
        height: CGFloat? = nil,
        spacing: CGFloat = 10,
        inset: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    ) -> Self {
        
        self.minimumLineSpacingForSectionAt { _,_,_ in spacing }
        self.minimumInteritemSpacingForSectionAt { _,_,_ in spacing }
        self.insetForSectionAt { _,_,_ in inset }
        
        self.sizeForItemAt { collectionView, _, _ in
            
            let containerWidth = collectionView.bounds.width - inset.left - inset.right
            
            switch style {
                
            case .fixed(let columns):
                
                let safeColumns = max(columns, 1)
                let totalSpacing = CGFloat(safeColumns - 1) * spacing
                let width = floor((containerWidth - totalSpacing) / CGFloat(safeColumns))
                
                return CGSize(width: width, height: height ?? width)
                
            case .flexible(let columns):
                
                let safeColumns = max(columns, 1)
                let totalSpacing = CGFloat(safeColumns - 1) * spacing
                let width = floor((containerWidth - totalSpacing) / CGFloat(safeColumns))
                
                let finalHeight = height ?? width * 0.75
                
                return CGSize(width: width, height: finalHeight)
                
            case .adaptive(let minWidth):
                
                let columns = max(1, Int(containerWidth / minWidth))
                let totalSpacing = CGFloat(columns - 1) * spacing
                let width = floor((containerWidth - totalSpacing) / CGFloat(columns))
                
                return CGSize(width: width, height: height ?? width)
            }
        }
        
        return self
    }
}

private struct GridConfig {
    var style: GridStyle
    var height: CGFloat?
    var spacing: CGFloat
    var inset: UIEdgeInsets
}

extension Collection {
    @discardableResult
    public func grid(_ style: GridStyle, section: Int, height: CGFloat? = nil, spacing: CGFloat = 10, inset: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)) -> Self {
        var configs = gridConfigs
        configs[section] = GridConfig(style: style, height: height, spacing: spacing, inset: inset)
        gridConfigs = configs
        ensureSelfDelegate()
        return self
    }
}
