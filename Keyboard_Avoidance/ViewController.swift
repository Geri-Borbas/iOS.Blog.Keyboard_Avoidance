//
//  ViewController.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 02/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit
import KeyboardLayoutGuide


class ViewController: UIViewController {
    
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
    
    lazy var content = UIStackView()
        .vertical(spacing: UI.spacing)
        .views(
            HeaderView(),
            emailTextField,
            givenNameTextField,
            familyNameTextField,
            passwordTextField,
            signUpButton
        )
    
    lazy var body = UIScrollView()
        .with {
            $0.addSubview(content)
            $0.keyboardDismissMode = .onDrag
            $0.showsVerticalScrollIndicator = false
            $0.bounces = false
        }
        .onMoveToSuperview {
            self.content.pin(to: $0)
            self.content.widthAnchor.constraint(equalTo: $0.widthAnchor).isActive = true
        }
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Hierarchy.
        view.addSubview(body)
        body.translatesAutoresizingMaskIntoConstraints = false
        body.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UI.padding).isActive = true
        body.bottomAnchor.constraint(
            equalTo: view.keyboardLayoutGuide.topAnchor,
            constant: -UI.padding
        ).isActive = true
        body.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: UI.padding).isActive = true
        body.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -UI.padding).isActive = true
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        content.heightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.heightAnchor,
            constant: -UI.padding * 2
        ).isActive = true
    }
}
