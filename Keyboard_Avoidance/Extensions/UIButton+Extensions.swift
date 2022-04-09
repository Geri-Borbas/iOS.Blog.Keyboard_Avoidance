//
//  UIButton+Extensions.swift
//  Half Modal
//
//  Created by Geri Borbás on 30/03/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


extension UIButton {
    
    typealias Action = () -> Void
    
    var action: Action? {
        get {
            associatedObject(for: "touchUpInsideAction") as? Action
        }
        set {
            set(associatedObject: newValue, for: "touchUpInsideAction")
        }
    }
    
    func onTouchUpInside(_ action: @escaping Action) -> Self {
        self.action = action
        addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
        return self
    }
    
    @objc func didTouchUpInside() {
        action?()
    }
}
