//
//  KeyboardLayoutGuide.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 02/04/2022.
//

import UIKit


@available(iOS, obsoleted: 15)
extension UIView {
    
    struct Keys {
        static var keyboardLayoutGuide: UInt8 = 0
    }
    
    var keyboardLayoutGuide: UIKeyboardLayoutGuide {
        get {
            objc_getAssociatedObject(self, &Keys.keyboardLayoutGuide) as? UIKeyboardLayoutGuide ?? UIKeyboardLayoutGuide(in: self)
        }
        set {
            objc_setAssociatedObject(self, &Keys.keyboardLayoutGuide, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


@available(iOS, obsoleted: 15)
class UIKeyboardLayoutGuide: UILayoutGuide {
    
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    var leftConstraint: NSLayoutConstraint?
    var rightConstraint: NSLayoutConstraint?
        
    init(in view: UIView) {
        super.init()
        
        // Add to view (bottom edge).
        view.addLayoutGuide(self)
        
        // Pin to the edges.
        self.topConstraint = self.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.height)
        self.bottomConstraint = self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        self.leftConstraint = self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        self.rightConstraint = self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        topConstraint?.isActive = true
        bottomConstraint?.isActive = true
        leftConstraint?.isActive = true
        rightConstraint?.isActive = true
        
        // Observe keyboard changes.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout(for keyboardFrame: CGRect, in coordinateSpace: UICoordinateSpace) {
        
        // Only if added to a view.
        guard let owningView = owningView else { return }
        
        // Geometry.
        let keyboardFrameInOwningView = owningView.convert(keyboardFrame, from: coordinateSpace)
        let intersection = owningView.bounds.intersection(keyboardFrameInOwningView)
        
        // Only if owning view is intersecting with the keyboard.
        guard intersection.isNull == false else { return }
        
        // Align constraints.
        topConstraint?.constant = intersection.minY
        bottomConstraint?.constant = intersection.maxY
        leftConstraint?.constant = intersection.minX
        rightConstraint?.constant = intersection.maxX
        
        // Invoke layout.
        owningView.layoutIfNeeded()
    }
    
    @objc private func keyboardWillChangeFrame(_ notification: NSNotification) {
        
        // Unwrap notification objects.
        guard let userInfo = notification.userInfo,
              let animationDurationNumber = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
              let animationCurveNumber = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
              let keyboardFrameBeginValue = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue,
              let keyboardFrameEndValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let window = UIApplication.shared.windows.first
        else {
            return
        }
        
        // Get notification values.
        let keyboardFrameBegin = keyboardFrameBeginValue.cgRectValue
        let keyboardFrameEnd = keyboardFrameEndValue.cgRectValue
        let animationCurveOptions = UIView.AnimationOptions(rawValue: animationCurveNumber.uintValue << 16)
        let animationDuration = animationDurationNumber.doubleValue
        
        // Layout begin.
        layout(for: keyboardFrameBegin, in: window)
        
        // Animate to end.
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: animationCurveOptions,
            animations: { [unowned self] in
                self.layout(for: keyboardFrameEnd, in: window)
            }
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
}
