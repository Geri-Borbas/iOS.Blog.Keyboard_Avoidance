//
//  WireframeViewController.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 03/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit
import KeyboardLayoutGuide


class WireframeViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Views.
        let firstNameTextField = UITextField()
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.returnKeyType = .done
        firstNameTextField.delegate = self
        
        let wireframe = WireframeView()
        wireframe.backgroundColor = .clear
        wireframe.alpha = 0.5
        wireframe.isUserInteractionEnabled = false
        
        // Hierarchy.
        view.addSubview(firstNameTextField)
        view.addSubview(wireframe)
        
        // Use this to ignore bottom safe area (in `keyboardLayoutGuide` as well).
        // view.insetsLayoutMarginsFromSafeArea = false
        
        // Constraints.
        wireframe.translatesAutoresizingMaskIntoConstraints = false
        wireframe.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        wireframe.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor).isActive = true
        wireframe.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        wireframe.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        firstNameTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        firstNameTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
