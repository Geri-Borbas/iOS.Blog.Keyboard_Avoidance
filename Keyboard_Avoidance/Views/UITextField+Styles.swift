//
//  UITextField+Styles.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 09/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit
import Withable


extension UITextField {
    
    var withEmailStyle: Self {
        withFormStyle(
            placeholder: "email",
            imageName: "envelope"
        )
        .with {
            $0.keyboardType = .emailAddress
            $0.autocapitalizationType = .none
        }
    }
    
    var withGivenNameStyle: Self {
        withFormStyle(
            placeholder: "given name",
            imageName: "person.crop.circle"
        )
    }
    
    var withFamilyNameStyle: Self {
        withFormStyle(
            placeholder: "family name",
            imageName: "equal.square"
        )
    }
    
    var withPasswordStyle: Self {
        withFormStyle(
            placeholder: "password",
            imageName: "lock"
        )
        .with {
            $0.isSecureTextEntry = true
        }
    }
    
    func with(next nextTextField: UITextField) -> Self {
        with {
            $0.nextTextField = nextTextField
        }
    }
    
    func withFormStyle(placeholder: String, imageName: String) -> Self {
        with {
            $0.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    .foregroundColor : UI.Color.label.withAlphaComponent(0.25)
                ]
            )
            $0.font = UIFont.rounded(size: 20)
            $0.textColor = UI.Color.label
            $0.backgroundColor = UI.Color.deepGray
            $0.layer.cornerRadius = 10
            $0.leftView = UIView()
                .with {
                    $0.isUserInteractionEnabled = false
                }
                .onMoveToSuperview {
                    $0.set(width: 20)
                    $0.set(height: 20)
                }
            $0.leftViewMode = .always
            let textField = $0
            $0.rightView = UIButton(type: .custom)
                .with {
                    $0.setImage(
                        UIImage(
                            systemName: imageName,
                            withConfiguration: UIImage.SymbolConfiguration(
                                pointSize: 30,
                                weight: .regular
                            )
                        ),
                        for: .normal
                    )
                    $0.imageView?.tintColor = UI.Color.label.withAlphaComponent(0.25)
                }
                .onMoveToSuperview {
                    $0.set(width: 10 + UI.itemHeight)
                    $0.set(height: UI.itemHeight)
                }
                .onTap {
                    textField.toggleFirstResponder()
                }
            $0.rightViewMode = .always
            $0.delegate = TextFieldDelegate.withFormStyle
            if let nextTextField = nextTextField {
                $0.nextTextField = nextTextField
                $0.returnKeyType = .next
            }
            
            // Slow-motion cursor blinking speed (for screencaps).
            // $0.textInputView.layer.speed = 0.1
        }
        .onMoveToSuperview {
            $0.set(height: UI.itemHeight)
        }
    }
}


extension UITextField {
    
    var nextTextField: UITextField? {
        get {
            associatedObject(for: "nextTextField") as? UITextField
        }
        set {
            set(associatedObject: newValue, for: "nextTextField")
        }
    }
}


extension TextFieldDelegate {
    
    static let withFormStyle = TextFieldDelegate(
        onBeginEditing: {
            $0.backgroundColor = UI.Color.darkGray
            ($0.rightView as? UIButton)?.imageView?.tintColor = UI.Color.blue
            $0.attributedPlaceholder = NSAttributedString(
                string: $0.placeholder ?? "",
                attributes: [
                    .foregroundColor : UI.Color.brightGray
                ]
            )
        },
        onEndEditing: {
            $0.backgroundColor = UI.Color.deepGray
            ($0.rightView as? UIButton)?.imageView?.tintColor = UI.Color.label.withAlphaComponent(0.25)
            $0.attributedPlaceholder = NSAttributedString(
                string: $0.placeholder ?? "",
                attributes: [
                    .foregroundColor : UI.Color.label.withAlphaComponent(0.25)
                ]
            )
        },
        onReturn: {
            $0.nextTextField?.becomeFirstResponder()
            $0.resignFirstResponder()
        }
    )
}
