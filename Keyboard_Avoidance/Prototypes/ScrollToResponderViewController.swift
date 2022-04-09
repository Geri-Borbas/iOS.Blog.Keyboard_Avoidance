//
//  ScrollToResponderViewController.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 07/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


class ScrollToResponderViewController: UIViewController {
    
    lazy var emailTextField = UITextField()
        .withFormStyle(
            placeholder: "email",
            imageName: "envelope",
            next: firstNameTextField
        )
        .with {
            $0.keyboardType = .emailAddress
            $0.autocapitalizationType = .none
        }
    
    lazy var firstNameTextField = UITextField()
        .withFormStyle(
            placeholder: "first name",
            imageName: "person.crop.circle",
            next: lastNameTextField
        )
    
    lazy var lastNameTextField = UITextField()
        .withFormStyle(
            placeholder: "last name",
            imageName: "equal.square",
            next: passwordTextField
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
    
    lazy var wrappedScrollView = UIView()
        .with {
            $0.addSubview(
                UIScrollView()
                    .withBorderedStyle
                    .with {
                        $0.addSubview(textFields)
                    }
                    .onMoveToSuperview {
                        $0.pin(to: $1)
                        self.textFields.pin(to: $0, insets: .init(top: 0, left: 10, bottom: 0, right: 10))
                        self.textFields.widthAnchor.constraint(equalTo: $0.widthAnchor, constant: -20).isActive = true
                    }
            )
            $0.addSubview(
                UIView()
                    .with {
                        $0.backgroundColor = UI.Color.background.withAlphaComponent(0.6)
                    }
                    .onMoveToSuperview {
                        $0.set(height: 500)
                        $0.topAnchor.constraint(equalTo: $1.bottomAnchor).isActive = true
                        $0.leftAnchor.constraint(equalTo: $1.leftAnchor).isActive = true
                        $0.rightAnchor.constraint(equalTo: $1.rightAnchor).isActive = true
                    }
            )
            $0.addSubview(
                UIView()
                    .with {
                        $0.backgroundColor = UI.Color.background.withAlphaComponent(0.6)
                    }
                    .onMoveToSuperview {
                        $0.set(height: 500)
                        $0.bottomAnchor.constraint(equalTo: $1.topAnchor).isActive = true
                        $0.leftAnchor.constraint(equalTo: $1.leftAnchor).isActive = true
                        $0.rightAnchor.constraint(equalTo: $1.rightAnchor).isActive = true
                    }
            )
        }
        .onMoveToSuperview {
            $0.set(height: 160) // 10 + 56 + 5 + 56 + 5 + 56 / 2
            // $0.set(height: 259) // 10 + 56 + 5 + 56 + 5 + 56 + 5 + 56 + 10
        }
    
    lazy var body = UIStackView()
        .vertical(spacing: 10)
        .views(
            UIView()
                .onMoveToSuperview {
                    $0.set(height: 89) // 56 + 5 + 56 / 2
                },
            wrappedScrollView,
            UIView.spacer
        )
        .onMoveToSuperview {
            $0.pin(to: self.view.safeAreaLayoutGuide, insets: .padding)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(body)
        view.backgroundColor = .systemBackground
    }
}


extension UIEdgeInsets {
    
    static let padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
}


extension UIScrollView {
    
    var withBorderedStyle: Self {
        with {
            $0.contentInset = .init(top: 10, left: 0, bottom: 10, right: 0)
            $0.layer.borderColor = UI.Color.label.withAlphaComponent(0.5).cgColor
            $0.layer.cornerRadius = 4
            $0.layer.borderWidth = 1
            $0.clipsToBounds = false
        }
    }
}
