//
//  ScrollToResponderViewController.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 07/04/2022.
//

import UIKit


class ScrollToResponderViewController: UIViewController {

    lazy var emailTextField = UITextField()
        .with {
            $0.placeholder = "email"
            $0.returnKeyType = .done
            $0.delegate = self
        }
        .withConstraints {
            $0.set(height: 40)
        }
    
    lazy var firstNameTextField = UITextField()
        .with {
            $0.attributedPlaceholder = NSAttributedString(
                string: "first name",
                attributes: [
                    .foregroundColor : UIColor.black
                ]
            )
            $0.font = UIFont.rounded(size: 20)
            $0.textColor = .white
            $0.backgroundColor = .gray
            $0.layer.cornerRadius = 10
            $0.leftView = UIView()
                .with {
                    $0.isUserInteractionEnabled = false
                }
                .withConstraints {
                    $0.set(width: 20)
                    $0.set(height: 20)
                    
                }
            $0.leftViewMode = .always
            let textField = $0
            $0.rightView = UIButton(type: .custom)
                .with {
                    $0.setImage(
                        UIImage(
                            systemName: "envelope",
                            withConfiguration: UIImage.SymbolConfiguration(
                                pointSize: 30,
                                weight: .regular
                            )
                        ),
                        for: .normal
                    )
                    $0.backgroundColor = .green
                    $0.imageView?.backgroundColor = .orange
                }
                .withConstraints {
                    $0.set(width: 10 + 56)
                    $0.set(height: 56)
                }
                .onTouchUpInside {
                    textField.toggleFirstResponder()
                }
            $0.rightViewMode = .always
            $0.delegate = self
        }
        .withConstraints {
            $0.set(height: 56)
        }
    
    lazy var lastNameTextField = UITextField()
        .with {
            $0.placeholder = "last name"
            $0.returnKeyType = .done
            $0.delegate = self
        }
        .withConstraints {
            $0.set(height: 40)
        }
    
    lazy var passwordTextField = UITextField()
        .with {
            $0.placeholder = "password"
            $0.isSecureTextEntry = true
            $0.returnKeyType = .done
            $0.delegate = self
        }
        .withConstraints {
            $0.set(height: 40)
        }
    
    lazy var textFields = UIStackView()
        .vertical(spacing: 10)
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
                            self.emailTextField.becomeFirstResponder()
                        }
                        .withConstraints {
                            $0.set(width: 50)
                        },
                    UIButton()
                        .with(title: "2")
                        .onTouchUpInside { [unowned self] in
                            self.firstNameTextField.becomeFirstResponder()
                        }
                        .withConstraints {
                            $0.set(width: 50)
                        },
                    UIButton()
                        .with(title: "3")
                        .onTouchUpInside { [unowned self] in
                            self.lastNameTextField.becomeFirstResponder()
                        }
                        .withConstraints {
                            $0.set(width: 50)
                        },
                    UIButton()
                        .with(title: "4")
                        .onTouchUpInside { [unowned self] in
                            self.passwordTextField.becomeFirstResponder()
                        }
                        .withConstraints {
                            $0.set(width: 50)
                        },
                    UIView.spacer
                ),
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


extension ScrollToResponderViewController: UITextFieldDelegate {
        
    @objc func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("\(Self.self).\(#function)")
        textField.backgroundColor = .white
        (textField.rightView as? UIButton)?.imageView?.tintColor = .systemBlue
        return true
    }
    
    @objc func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("\(Self.self).\(#function)")
        textField.backgroundColor = .gray
        (textField.rightView as? UIButton)?.imageView?.tintColor = .gray
        return true
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("\(Self.self).\(#function)")
        textField.resignFirstResponder()
        return true
    }
}


class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    typealias TextFieldAction = (_ textField: UITextField) -> Void
    
    var onBeginEditing: TextFieldAction?
    var onEndEditing: TextFieldAction?
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        onBeginEditing?(textField)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        onEndEditing?(textField)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension UIResponder {
    
    func toggleFirstResponder() {
        if isFirstResponder {
            resignFirstResponder()
        } else {
            becomeFirstResponder()
        }
    }
}


extension UIEdgeInsets {
    
    static let padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
}
