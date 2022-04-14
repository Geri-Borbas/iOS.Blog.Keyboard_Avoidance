//
//  UIResponder+Extensions.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 08/04/2022.
//  http://www.twitter.com/Geri_Borbas
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
