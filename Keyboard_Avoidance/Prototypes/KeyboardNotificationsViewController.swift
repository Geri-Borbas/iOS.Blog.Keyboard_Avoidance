//
//  KeyboardNotificationsViewController.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 06/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


class KeyboardNotificationsViewController: UIViewController {
    
    lazy var emailTextField = UITextField()
        .withEmailStyle
        .with(next: givenNameTextField)
    
    lazy var givenNameTextField = UITextField()
        .withGivenNameStyle
        .with(next: familyNameTextField)
    
    lazy var familyNameTextField = UITextField()
        .withFamilyNameStyle
        .with(next: passwordTextField)
    
    lazy var passwordTextField = UITextField()
        .withPasswordStyle
    
    lazy var signUpButton = UIButton()
        .withSignUpButtonStyle
    
    lazy var body = UIStackView()
        .vertical(spacing: UI.spacing)
        .views(
            HeaderView(),
            emailTextField,
            givenNameTextField,
            familyNameTextField,
            passwordTextField,
            signUpButton
        )
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Hierarchy.
        view.addSubview(body)
        body.translatesAutoresizingMaskIntoConstraints = false
        body.topAnchor.constraint(equalTo: view.topAnchor, constant: UI.padding).isActive = true
        self.bottomConstraint = body.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -UI.padding
        ).with { $0.isActive = true }
        body.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: UI.padding).isActive = true
        body.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -UI.padding).isActive = true
        
        // Observe keyboard frame changes.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        self.bottomConstraint?.constant = -view.safeAreaInsets.bottom - UI.padding
    }
    
    @objc private func keyboardWillChangeFrame(_ notification: NSNotification) {
        
        // Unwrap notification objects.
        guard let userInfo = notification.userInfo,
              let animationDurationNumber = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
              let animationCurveNumber = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
              let _ = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue,
              let keyboardFrameEndValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let window = UIApplication.firstWindow
        else {
            return
        }
        
        // Get notification values.
        let keyboardFrameEnd = keyboardFrameEndValue.cgRectValue
        let animationCurveOptions = UIView.AnimationOptions(rawValue: animationCurveNumber.uintValue << 16)
        let animationDuration = animationDurationNumber.doubleValue
        
        // Get keyboard height.
        let keyboardFrameInView = view.convert(keyboardFrameEnd, from: window)
        let intersection = view.bounds.intersection(keyboardFrameInView)
        let keyboardHeight = intersection.isNull ? 0 : intersection.size.height
        
        // Animate bottom constraint.
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: animationCurveOptions,
            animations: { [unowned self] in
                let bottomInset = keyboardHeight > 0 ? keyboardHeight : view.safeAreaInsets.bottom
                self.bottomConstraint?.constant = -bottomInset - UI.padding
                view.layoutIfNeeded()
            }
        )
    }
}


fileprivate extension UIApplication {
    
    static var firstWindow: UIWindow? {
        if #available(iOS 15.0, *) {
            return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
        } else {
            return UIApplication.shared.windows.first
        }
    }
}
