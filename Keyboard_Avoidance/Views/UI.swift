//
//  UI.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 08/04/2022.
//

import UIKit


extension UITextField {
    
    func withFormStyle(placeholder: String, imageName: String) -> Self {
        with {
            $0.attributedPlaceholder = NSAttributedString(
                string: placeholder,
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
                            systemName: imageName,
                            withConfiguration: UIImage.SymbolConfiguration(
                                pointSize: 30,
                                weight: .regular
                            )
                        ),
                        for: .normal
                    )
                    $0.imageView?.tintColor = .gray
                }
                .withConstraints {
                    $0.set(width: 10 + 56)
                    $0.set(height: 56)
                }
                .onTouchUpInside {
                    textField.toggleFirstResponder()
                }
            $0.rightViewMode = .always
            $0.delegate = TextFieldDelegate.withFormStyle
        }
        .withConstraints {
            $0.set(height: 56)
        }
    }
}


extension TextFieldDelegate {
    
    static let withFormStyle = TextFieldDelegate(
        onBeginEditing: {
            $0.backgroundColor = .white
            ($0.rightView as? UIButton)?.imageView?.tintColor = .systemBlue
        },
        onEndEditing: {
            $0.backgroundColor = .gray
            ($0.rightView as? UIButton)?.imageView?.tintColor = .gray
        },
        onReturn: {
            $0.resignFirstResponder()
        }
    )
}
