//
//  UIFont+Extensions.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 08/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


extension UIFont {
    
    class func rounded(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        if let descriptor = UIFont.systemFont(ofSize: size, weight: weight).fontDescriptor.withDesign(.rounded) {
            return .init(descriptor: descriptor, size: size)
        } else {
            return .systemFont(ofSize: size, weight: weight)
        }
    }
}
