//
//  KeyboardLayoutGuideViewController.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 11/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


class KeyboardLayoutGuideViewController: UIViewController {
    
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
        body.bottomAnchor.constraint(
            equalTo: view.keyboardLayoutGuide.topAnchor,
            constant: -UI.padding
        ).isActive = true
        body.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: UI.padding).isActive = true
        body.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -UI.padding).isActive = true
    }
}
