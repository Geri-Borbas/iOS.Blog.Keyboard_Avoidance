//
//  ScrollToResponderViewController.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 07/04/2022.
//

import UIKit


class ScrollToResponderViewController: UIViewController {
        
    lazy var emailTextField = UITextField()
        .withFormStyle(
            placeholder: "email",
            imageName: "envelope"
        )
    
    lazy var firstNameTextField = UITextField()
        .withFormStyle(
            placeholder: "first name",
            imageName: "person.crop.circle"
        )
    
    lazy var lastNameTextField = UITextField()
        .withFormStyle(
            placeholder: "last name",
            imageName: "equal.square"
        )
    
    lazy var passwordTextField = UITextField()
        .withFormStyle(
            placeholder: "password",
            imageName: "lock"
        )
        .with {
            $0.isSecureTextEntry = true
        }
    
    lazy var textFields = UIStackView()
        .vertical(spacing: 5)
        .views(
            emailTextField,
            firstNameTextField,
            lastNameTextField,
            passwordTextField
        )
        .withConstraints {
            $0.pin(to: self.scrollView, insets: .zero)
            $0.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: 0).isActive = true
        }
    
    lazy var scrollView = UIScrollView()
        .with {
            $0.clipsToBounds = false
            $0.backgroundColor = .orange
        }
        .withConstraints {
            $0.set(height: 100)
        }
    
    lazy var body = UIStackView()
        .vertical(spacing: 10)
        .views(
            scrollView,
            UIStackView()
                .horizontal(spacing: 10)
                .views(
                    UIView.spacer,
                    UIButton()
                        .with(title: "1")
                        .onTouchUpInside { [unowned self] in
                            self.emailTextField.toggleFirstResponder()
                        }
                        .withConstraints {
                            $0.set(width: 50)
                        },
                    UIButton()
                        .with(title: "2")
                        .onTouchUpInside { [unowned self] in
                            self.firstNameTextField.toggleFirstResponder()
                        }
                        .withConstraints {
                            $0.set(width: 50)
                        },
                    UIButton()
                        .with(title: "3")
                        .onTouchUpInside { [unowned self] in
                            self.lastNameTextField.toggleFirstResponder()
                        }
                        .withConstraints {
                            $0.set(width: 50)
                        },
                    UIButton()
                        .with(title: "4")
                        .onTouchUpInside { [unowned self] in
                            self.passwordTextField.toggleFirstResponder()
                        }
                        .withConstraints {
                            $0.set(width: 50)
                        },
                    UIView.spacer
                )
                .with {
                    $0.distribution = .fillEqually
                },
            UIView.spacer
        )
        .withConstraints {
            $0.pin(to: self.view.safeAreaLayoutGuide, insets: .padding)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(textFields)
        view.addSubview(body)
        view.backgroundColor = .systemBackground
    }
}


extension UIEdgeInsets {
    
    static let padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
}
