//
//  UI.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 08/04/2022.
//

import UIKit


struct UI {
    
    struct Color {
        
        static let label = UIColor.init(named: "Label") ?? .notFound
        static let gray = UIColor.init(named: "Gray") ?? .notFound
        static let brightGray = UIColor.init(named: "Bright Gray") ?? .notFound
        static let middleGray = UIColor.init(named: "Middle Gray") ?? .notFound
        static let darkGray = UIColor.init(named: "Dark Gray") ?? .notFound
        static let deepGray = UIColor.init(named: "Deep Gray") ?? .notFound
        static let background = UIColor.init(named: "Background") ?? .notFound
        static let blue = UIColor.systemBlue
    }
}


extension UIColor {
    
    static let notFound = UIColor.magenta
}


extension UITextField {
    
    func withFormStyle(placeholder: String, imageName: String) -> Self {
        with {
            $0.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    .foregroundColor : UI.Color.middleGray
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
                    $0.imageView?.tintColor = UI.Color.middleGray
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
            ($0.rightView as? UIButton)?.imageView?.tintColor = UI.Color.middleGray
            $0.attributedPlaceholder = NSAttributedString(
                string: $0.placeholder ?? "",
                attributes: [
                    .foregroundColor : UI.Color.middleGray
                ]
            )
        },
        onReturn: {
            $0.resignFirstResponder()
        }
    )
}
