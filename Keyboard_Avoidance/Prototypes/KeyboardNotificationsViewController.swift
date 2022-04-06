//
//  KeyboardNotificationsViewController.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 06/04/2022.
//

import UIKit


class KeyboardNotificationsViewController: UIViewController, UITextFieldDelegate {

    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Views.
        let headerLabel = UITextField()
        headerLabel.text = "Sign In"
        
        let usernameTextField = UITextField()
        usernameTextField.placeholder = "username"
        usernameTextField.returnKeyType = .done
        usernameTextField.delegate = self
        
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "password"
        passwordTextField.returnKeyType = .done
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        
        // Hierarchy.
        view.addSubview(headerLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        
        // Constraints.
        let padding = CGFloat(15)
        let spacing = CGFloat(5)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: padding).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.bottomConstraint = passwordTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        self.bottomConstraint?.isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: padding).isActive = true
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: spacing).isActive = true
        usernameTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        usernameTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: padding).isActive = true
        
        // Observe keyboard frame changes.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
                self.bottomConstraint?.constant = -keyboardHeight
                view.layoutIfNeeded()
            }
        )
    }
}
