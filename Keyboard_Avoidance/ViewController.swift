//
//  ViewController.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 02/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


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
        .vertical(spacing: 5)
        .views(
            HeaderView()
                .withFixedHeight,
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
        body.topAnchor.constraint(equalTo: view.topAnchor, constant: UI.spacing).isActive = true
        body.bottomAnchor.constraint(
            equalTo: view.keyboardLayoutGuide.topAnchor,
            constant: -UI.spacing
        ).isActive = true
        body.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: UI.spacing).isActive = true
        body.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -UI.spacing).isActive = true
    }
}
