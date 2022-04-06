//
//  KeyboardLayoutGuide.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 02/04/2022.
//

import UIKit
import Combine


@available(iOS, obsoleted: 15)
extension UIView {
    
    struct Keys {
        static var keyboardLayoutGuide: UInt8 = 0
    }
    
    var keyboardLayoutGuide: UIKeyboardLayoutGuide {
        get {
            if let instance = objc_getAssociatedObject(self, &Keys.keyboardLayoutGuide) as? UIKeyboardLayoutGuide {
                return instance
            } else {
                let instance = UIKeyboardLayoutGuide(in: self)
                objc_setAssociatedObject(self, &Keys.keyboardLayoutGuide, instance, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return instance
            }
        }
    }
}


@available(iOS, obsoleted: 15)
class UIKeyboardLayoutGuide: UILayoutGuide {
    
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    var leftConstraint: NSLayoutConstraint?
    var rightConstraint: NSLayoutConstraint?
    var isKeyboardShown: Bool = false
    var subscribers: [AnyCancellable] = []
    
    init(in view: UIView) {
        super.init()
        
        // Add to view (bottom edge).
        view.addLayoutGuide(self)
        
        // Pin to the edges.
        self.topConstraint = self.topAnchor.constraint(equalTo: view.topAnchor, constant: view.layoutMarginsGuide.layoutFrame.size.height)
        self.bottomConstraint = self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        self.leftConstraint = self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        self.rightConstraint = self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        topConstraint?.isActive = true
        bottomConstraint?.isActive = true
        leftConstraint?.isActive = true
        rightConstraint?.isActive = true
        
        // Observe keyboard changes and orientation transitions.
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .sink { [unowned self] notification in self.keyboardWillChangeFrame(notification) }
            .store(in: &subscribers)
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [unowned self] _ in self.isKeyboardShown = true }
            .store(in: &subscribers)
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [unowned self] _ in self.isKeyboardShown = false }
            .store(in: &subscribers)
        NotificationCenter.default
            .publisher(for: UIWindow.didBecomeKeyNotification)
            .sink { [unowned self] notification in
                if let window = notification.object as? UIWindow {
                    self.layout(for: window.bounds.bottomEdgeRect, in: window)
                }
            }
            .store(in: &subscribers)
        OrientationListenerViewController.shared.viewWillTransition
            .sink { [unowned self] size, coordinator in
                if self.isKeyboardShown == false {
                    self.viewWillTransition(to: size, with: coordinator)
                }
            }
            .store(in: &subscribers)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func keyboardWillChangeFrame(_ notification: Notification) {
        
        // Unwrap window.
        guard let window = UIApplication.shared.windows.first else { return }
        
        // Layout using keyboard animation data.
        animate(
            from: notification.keyboardFrameBegin,
            to: notification.keyboardFrameEnd,
            in: window,
            duration: notification.animationDuration,
            options: notification.animationCurveOptions
        )
    }
    
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { [unowned self] coordinator in
            self.layout(for: size.rect.bottomEdgeRect, in: coordinator.containerView)
        }
    }
    
    func animate(
        from keyboardFrameBegin: CGRect,
        to keyboardFrameEnd: CGRect,
        in coordinateSpace: UICoordinateSpace,
        duration: Double = 0,
        options: UIView.AnimationOptions = []
    ) {
        // Set frame immediately if not animated.
        guard duration > 0 else {
            layout(for: keyboardFrameEnd, in: coordinateSpace)
            return
        }
        
        // Layout begin.
        layout(for: keyboardFrameBegin, in: coordinateSpace)
        
        // Animate to end.
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: options,
            animations: { [unowned self] in
                self.layout(for: keyboardFrameEnd, in: coordinateSpace)
            }
        )
    }
    
    func layout(for keyboardFrame: CGRect, in coordinateSpace: UICoordinateSpace) {
        
        // Only if added to a view.
        guard let owningView = owningView else { return }
        
        // Geometry.
        let keyboardFrameInOwningView = owningView.convert(keyboardFrame, from: coordinateSpace)
        let intersection = owningView.layoutMarginsGuide.layoutFrame.intersection(keyboardFrameInOwningView)
        
        // Intersecting with the keyboard or the bottom edge of the safe area.
        let resulting = intersection.isNull ? owningView.layoutMarginsGuide.layoutFrame.bottomEdgeRect : intersection
        
        // Align constraints.
        topConstraint?.constant = resulting.minY
        bottomConstraint?.constant = resulting.maxY
        leftConstraint?.constant = resulting.minX
        rightConstraint?.constant = resulting.maxX
        
        // Invoke layout.
        owningView.layoutIfNeeded()
    }
}


fileprivate extension Notification {
    
    var keyboardFrameBegin: CGRect {
        if let userInfo = self.userInfo,
           let value = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue {
            return value.cgRectValue
        } else {
            return CGRect.zero
        }
    }
    
    var keyboardFrameEnd: CGRect {
        if let userInfo = self.userInfo,
           let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            return value.cgRectValue
        } else {
            return CGRect.zero
        }
    }
    
    var animationDuration: Double {
        if let userInfo = self.userInfo,
           let value = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            return value.doubleValue
        } else {
            return 0
        }
    }
    
    var animationCurveOptions: UIView.AnimationOptions {
        if let userInfo = self.userInfo,
           let value = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
            return UIView.AnimationOptions(rawValue: value.uintValue << 16)
        } else {
            return []
        }
    }
    
    func log() {
        print("keyboardFrameBegin: \(keyboardFrameBegin)")
        print("keyboardFrameEnd: \(keyboardFrameEnd)")
        print("animationCurveOptions: \(animationCurveOptions)")
        print("animationDuration: \(animationDuration)")
    }
}


extension UIView.AnimationCurve {
    
    var animationOption: UIView.AnimationOptions {
        switch self {
        case .easeInOut:
            return .curveEaseInOut
        case .easeIn:
            return .curveEaseIn
        case .easeOut:
            return .curveEaseOut
        case .linear:
            return .curveLinear
        @unknown default:
            return .curveLinear
        }
    }
}


extension CGSize {
    
    var rect: CGRect {
        .init(origin: .zero, size: self)
    }
}


extension CGRect {
    
    var bottomEdgeRect: CGRect {
        .init(
            x: minX,
            y: maxY,
            width: size.width,
            height: .zero
        )
    }
}
