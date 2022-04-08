//
//  WireframeViewController.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 03/04/2022.
//

import UIKit


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
        
//        wireframe.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor).isActive = true
        let wireframeBottomConstraint =  wireframe.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: 0)
        view.keyboardLayoutGuide.followsUndockedKeyboard = true
        view.keyboardLayoutGuide.setConstraints([wireframeBottomConstraint], activeWhenAwayFrom: .bottom)
//        view.keyboardLayoutGuide.setConstraints([wireframeBottomConstraint], activeWhenNearEdge: .bottom)
        
        // Constraints.
        wireframe.translatesAutoresizingMaskIntoConstraints = false
        wireframe.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
       
        wireframe.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        wireframe.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        firstNameTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        firstNameTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
