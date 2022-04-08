//
//  UIView+Constraints.swift
//  Half Modal
//
//  Created by Geri Borbás on 31/03/2022.
//

import UIKit


extension UIView {
    
    typealias ViewAction = (_ view: UIView) -> Void
    typealias ViewAndSuperviewAction = (_ view: UIView, _ superview: UIView) -> Void
    
    /// The `onMoveToSuperview` closure will be called once, right after this view called its
    /// `didMoveToSuperView()`. Suitable place to add constraints to this view instance.
    /// See https://developer.apple.com/documentation/uikit/uiview/1622512-updateconstraints
    @discardableResult func withConstraints(_ onMoveToSuperview: @escaping ViewAction) -> Self {
        self.onMoveToSuperview = onMoveToSuperview
        return self
    }
    
    @discardableResult func withConstraints(_ onMoveToSuperview: @escaping ViewAndSuperviewAction) -> Self {
        self.onMoveToSuperview = { view in
            guard let superview = self.superview else { return }
            onMoveToSuperview(self, superview)
        }
        return self
    }
}


extension UIView {
    
    static var notSwizzled = true
    
    struct Keys {
        static var viewAction: UInt8 = 0
    }
    
    /// The `onMoveToSuperview` closure will be called once, right after this view called its
    /// `didMoveToSuperView()`. Suitable place to add constraints to this view instance.
    /// See https://developer.apple.com/documentation/uikit/uiview/1622512-updateconstraints
    var onMoveToSuperview: ViewAction? {
        get {
            objc_getAssociatedObject(self, &Keys.viewAction) as? ViewAction
        }
        set {
            swizzleIfNeeded()
            objc_setAssociatedObject(self, &Keys.viewAction, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc fileprivate func originalDidMoveToSuperview() {
        // Original implementation will be copied here.
    }
    
    @objc fileprivate func swizzledDidMoveToSuperview() {
        originalDidMoveToSuperview()
        if superview != nil {
            onMoveToSuperview?(self)
            onMoveToSuperview = nil
        }
    }
    
    fileprivate func swizzleIfNeeded() {
        
        guard Self.notSwizzled else {
            return
        }
        
        guard let viewClass: AnyClass = object_getClass(self) else {
            return print("Could not get `UIView` class.")
        }
        
        let selector = #selector(didMoveToSuperview)
        guard let method = class_getInstanceMethod(viewClass, selector) else {
            return print("Could not get `didMoveToSuperview()` selector.")
        }
        
        let originalSelector = #selector(originalDidMoveToSuperview)
        guard let originalMethod = class_getInstanceMethod(viewClass, originalSelector) else {
            return print("Could not get original `originalDidMoveToSuperview()` selector.")
        }
        
        let swizzledSelector = #selector(swizzledDidMoveToSuperview)
        guard let swizzledMethod = class_getInstanceMethod(viewClass, swizzledSelector) else {
            return print("Could not get swizzled `swizzledDidMoveToSuperview()` selector.")
        }
        
        // Swap implementations.
        method_exchangeImplementations(method, originalMethod)
        method_exchangeImplementations(method, swizzledMethod)
        
        // Flag.
        Self.notSwizzled = false
    }
}
