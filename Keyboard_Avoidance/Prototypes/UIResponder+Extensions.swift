//
//  UIResponder+Extensions.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 08/04/2022.
//

import UIKit


extension UIResponder {
    
    func toggleFirstResponder() {
        if isFirstResponder {
            resignFirstResponder()
        } else {
            becomeFirstResponder()
        }
    }
}
