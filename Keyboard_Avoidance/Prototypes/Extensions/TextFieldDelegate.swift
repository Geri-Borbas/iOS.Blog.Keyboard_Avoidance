//
//  TextFieldDelegate.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 08/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    typealias TextFieldAction = (_ textField: UITextField) -> Void
    
    let onBeginEditing: TextFieldAction?
    let onEndEditing: TextFieldAction?
    let onReturn: TextFieldAction?
    
    init(
        onBeginEditing: TextFieldAction? = nil,
        onEndEditing: TextFieldAction? = nil,
        onReturn: TextFieldAction? = nil
    ) {
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        self.onReturn = onReturn
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        onBeginEditing?(textField)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        onEndEditing?(textField)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onReturn?(textField)
        return true
    }
}
