//
//  UIView+KeyboardLayoutGuide.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 14/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


@available(iOS, obsoleted: 15)
extension UIView {
    
    @available(iOS, obsoleted: 15)
    var keyboardLayoutGuide: KeyboardLayoutGuide {
        get {
            if let instance = associatedObject(for: "keyboardLayoutGuide") as? KeyboardLayoutGuide {
                return instance
            } else {
                let instance = KeyboardLayoutGuide(in: self)
                set(associatedObject: instance, for: "keyboardLayoutGuide")
                return instance
            }
        }
    }
}
