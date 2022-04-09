//
//  UIView+Speed.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 23/03/2022.
//  http://www.twitter.com/Geri_Borbas
//

import Foundation
import UIKit


extension UIView {
    
    static var speed: Speed = Speed() {
        didSet {
            // UIApplication.shared.windows.first?.layer.speed = speed.layerSpeed
            UIScrollView.setupSpeed()
        }
    }
    
    struct Speed {
        
        let layerSpeed: Float
        let decelerationRate: CGFloat
        let contentOffsetAnimationDuration: CGFloat
        let pagingFriction: CGFloat
        
        init(
            layerSpeed: Float = 1.0,
            decelerationRate: CGFloat = 0.998,
            contentOffsetAnimationDuration: CGFloat = 0.3,
            pagingFriction: CGFloat = 0.9702286931818183
        ) {
            self.layerSpeed = layerSpeed
            self.decelerationRate = decelerationRate
            self.contentOffsetAnimationDuration = contentOffsetAnimationDuration
            self.pagingFriction = pagingFriction
        }
        
        static var half = Speed(
            layerSpeed: 0.5,
            decelerationRate: 0.998,
            contentOffsetAnimationDuration: 0.6,
            pagingFriction: 0.9413437171
        )
    }
}


extension UIScrollView {
    
    static func setupSpeed() {
        
        // Only if tweaked.
        guard Self.speed.layerSpeed != 1.0 else {
            return
        }
        
        // Bounce deceleration(s).
        swizzleGetBouncingDecelerationOffset()
        swizzleGetPagingDecelerationOffset()
        swizzleGetStandardDecelerationOffset()
        
        // Animation duration after refreshing.
        swizzleContentOffsetAnimationDuration()
        // self.setValue(Self.speed.contentOffsetAnimationDuration, forKey: "contentOffsetAnimationDuration")
    }
}


// MARK: Content offset animation duration

extension UIScrollView {
    
    static func swizzleContentOffsetAnimationDuration() {
        
        guard let scrollViewClass: AnyClass = object_getClass(UIScrollView()) else {
            return print("Could not get `UIScrollView` class.")
        }
        
        let selectorName = "_contentOffsetAnimationDuration"
        let selector = Selector(selectorName)
        guard let method = class_getInstanceMethod(scrollViewClass, selector) else {
            return print("Could not get `contentOffsetAnimationDuration()` selector.")
        }
        
        let originalSelector = #selector(originalContentOffsetAnimationDuration)
        guard let originalMethod = class_getInstanceMethod(scrollViewClass, originalSelector) else {
            return print("Could not get original `contentOffsetAnimationDuration()` selector.")
        }
        
        let swizzledSelector = #selector(swizzledContentOffsetAnimationDuration)
        guard let swizzledMethod = class_getInstanceMethod(scrollViewClass, swizzledSelector) else {
            return print("Could not get swizzled `contentOffsetAnimationDuration()` selector.")
        }
        
        // Swap implementations.
        method_exchangeImplementations(method, originalMethod)
        method_exchangeImplementations(method, swizzledMethod)
    }
    
    // - (double)_contentOffsetAnimationDuration;
    
    @objc func originalContentOffsetAnimationDuration() -> Double {
        return 0 // Original implementation will be copied here
    }
    
    @objc func swizzledContentOffsetAnimationDuration() -> Double {
        print("\(Self.self).\(#function)")
        return originalContentOffsetAnimationDuration() * CGFloat(Self.speed.layerSpeed) // ✨
    }
}


// MARK: Bouncing speed

extension UIScrollView {
    
    static func swizzleGetBouncingDecelerationOffset() {
        
        guard let scrollViewClass: AnyClass = object_getClass(UIScrollView()) else {
            return print("Could not get `UIScrollView` class.")
        }
        
        let selectorName = "_getBouncingDecelerationOffset:forTimeInterval:lastUpdateOffset:min:max:decelerationFactor:decelerationLnFactor:velocity:"
        let selector = Selector(selectorName)
        guard let method = class_getInstanceMethod(scrollViewClass, selector) else {
            return print("Could not get `getBouncingDecelerationOffset()` selector.")
        }
        
        let originalSelector = #selector(originalGetBouncingDecelerationOffset(_:forTimeInterval:lastUpdateOffset:min:max:decelerationFactor:decelerationLnFactor:velocity:))
        guard let originalMethod = class_getInstanceMethod(scrollViewClass, originalSelector) else {
            return print("Could not get original `getBouncingDecelerationOffset()` selector.")
        }
        
        let swizzledSelector = #selector(swizzledGetBouncingDecelerationOffset(_:forTimeInterval:lastUpdateOffset:min:max:decelerationFactor:decelerationLnFactor:velocity:))
        guard let swizzledMethod = class_getInstanceMethod(scrollViewClass, swizzledSelector) else {
            return print("Could not get swizzled `getBouncingDecelerationOffset()` selector.")
        }
        
        // Swap implementations.
        method_exchangeImplementations(method, originalMethod)
        method_exchangeImplementations(method, swizzledMethod)
    }
    
    //	- (BOOL)_getBouncingDecelerationOffset:(double*)arg1
    //	forTimeInterval:(double)arg2
    //	lastUpdateOffset:(double)arg3
    //	min:(double)arg4
    //	max:(double)arg5
    //	decelerationFactor:(double)arg6
    //	decelerationLnFactor:(double)arg7
    //	velocity:(double*)arg8;
    
    @objc func originalGetBouncingDecelerationOffset(
        _ bouncingDecelerationOffset: UnsafeMutablePointer<CGFloat>,
        forTimeInterval timeInterval: TimeInterval,
        lastUpdateOffset: TimeInterval,
        min: CGFloat,
        max: CGFloat,
        decelerationFactor: CGFloat,
        decelerationLnFactor: CGFloat,
        velocity: UnsafeMutablePointer<CGFloat>
    ) -> Bool {
        return true // Original implementation will be copied here
    }
    
    @objc func swizzledGetBouncingDecelerationOffset(
        _ bouncingDecelerationOffset: UnsafeMutablePointer<CGFloat>,
        forTimeInterval timeInterval: TimeInterval,
        lastUpdateOffset: TimeInterval,
        min: CGFloat,
        max: CGFloat,
        decelerationFactor: CGFloat,
        decelerationLnFactor: CGFloat,
        velocity: UnsafeMutablePointer<CGFloat>
    ) -> Bool {
        return originalGetBouncingDecelerationOffset(
            bouncingDecelerationOffset,
            forTimeInterval: timeInterval * CGFloat(Self.speed.layerSpeed), // ✨
            lastUpdateOffset: lastUpdateOffset,
            min: min,
            max: max,
            decelerationFactor: decelerationFactor,
            decelerationLnFactor: decelerationLnFactor,
            velocity: velocity
        )
    }
}


// MARK: Standard speed

extension UIScrollView {
    
    static func swizzleGetStandardDecelerationOffset() {
        
        guard let scrollViewClass: AnyClass = object_getClass(UIScrollView()) else {
            return print("Could not get `UIScrollView` class.")
        }
        
        let selectorName = "_getStandardDecelerationOffset:forTimeInterval:min:max:decelerationFactor:decelerationLnFactor:velocity:"
        let selector = Selector(selectorName)
        guard let method = class_getInstanceMethod(scrollViewClass, selector) else {
            return print("Could not get `getStandardDecelerationOffset()` selector.")
        }
        
        let originalSelector = #selector(originalGetStandardDecelerationOffset(_:forTimeInterval:min:max:decelerationFactor:decelerationLnFactor:velocity:))
        guard let originalMethod = class_getInstanceMethod(scrollViewClass, originalSelector) else {
            return print("Could not get original `getStandardDecelerationOffset()` selector.")
        }
        
        let swizzledSelector = #selector(swizzledGetStandardDecelerationOffset(_:forTimeInterval:min:max:decelerationFactor:decelerationLnFactor:velocity:))
        guard let swizzledMethod = class_getInstanceMethod(scrollViewClass, swizzledSelector) else {
            return print("Could not get swizzled `getStandardDecelerationOffset()` selector.")
        }
        
        // Swap implementations.
        method_exchangeImplementations(method, originalMethod)
        method_exchangeImplementations(method, swizzledMethod)
    }
    
    //	- (void)_getStandardDecelerationOffset:(double*)arg1
    //	forTimeInterval:(double)arg2
    //	min:(double)arg3
    //	max:(double)arg4
    //	decelerationFactor:(double)arg5
    //	decelerationLnFactor:(double)arg6
    //	velocity:(double*)arg7;
    
    @objc func originalGetStandardDecelerationOffset(
        _ standardDecelerationOffset: UnsafeMutablePointer<CGFloat>,
        forTimeInterval timeInterval: TimeInterval,
        min: CGFloat,
        max: CGFloat,
        decelerationFactor: CGFloat,
        decelerationLnFactor: CGFloat,
        velocity: UnsafeMutablePointer<CGFloat>
    ) -> Bool {
        return true // Original implementation will be copied here
    }
    
    @objc func swizzledGetStandardDecelerationOffset(
        _ standardDecelerationOffset: UnsafeMutablePointer<CGFloat>,
        forTimeInterval timeInterval: TimeInterval,
        min: CGFloat,
        max: CGFloat,
        decelerationFactor: CGFloat,
        decelerationLnFactor: CGFloat,
        velocity: UnsafeMutablePointer<CGFloat>
    ) -> Bool {
        return originalGetStandardDecelerationOffset(
            standardDecelerationOffset,
            forTimeInterval: timeInterval * CGFloat(Self.speed.layerSpeed), // ✨
            min: min,
            max: max,
            decelerationFactor: decelerationFactor,
            decelerationLnFactor: decelerationLnFactor,
            velocity: velocity
        )
    }
}


// MARK: Paging speed

extension UIScrollView {
    
    static func swizzleGetPagingDecelerationOffset() {
        
        guard let scrollViewClass: AnyClass = object_getClass(UIScrollView()) else {
            return print("Could not get `UIScrollView` class.")
        }
        
        let selectorName = "_getPagingDecelerationOffset:forTimeInterval:"
        let selector = Selector(selectorName)
        guard let method = class_getInstanceMethod(scrollViewClass, selector) else {
            return print("Could not get `getPagingDecelerationOffset()` selector.")
        }
        
        let originalSelector = #selector(originalGetPagingDecelerationOffset(_:forTimeInterval:))
        guard let originalMethod = class_getInstanceMethod(scrollViewClass, originalSelector) else {
            return print("Could not get original `getPagingDecelerationOffset()` selector.")
        }
        
        let swizzledSelector = #selector(swizzledGetPagingDecelerationOffset(_:forTimeInterval:))
        guard let swizzledMethod = class_getInstanceMethod(scrollViewClass, swizzledSelector) else {
            return print("Could not get swizzled `getPagingDecelerationOffset()` selector.")
        }
        
        // Swap implementations.
        method_exchangeImplementations(method, originalMethod)
        method_exchangeImplementations(method, swizzledMethod)
    }
    
    //	- (bool)_getPagingDecelerationOffset:(struct CGPoint { double x1; double x2; }*)arg1
    //	forTimeInterval:(double)arg2;
    
    @objc func originalGetPagingDecelerationOffset(
        _ standardDecelerationOffset: UnsafeMutablePointer<CGFloat>,
        forTimeInterval timeInterval: TimeInterval
    ) -> Bool {
        return true // Original implementation will be copied here
    }
    
    @objc func swizzledGetPagingDecelerationOffset(
        _ standardDecelerationOffset: UnsafeMutablePointer<CGFloat>,
        forTimeInterval timeInterval: TimeInterval
    ) -> Bool {
        return originalGetPagingDecelerationOffset(
            standardDecelerationOffset,
            forTimeInterval: timeInterval * CGFloat(Self.speed.layerSpeed) // ✨
        )
    }
}
