//
//  UI.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 08/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


struct UI {
    
    static let spacing = CGFloat(15)
    
    struct Color {
        
        static let label = UIColor.init(named: "Label") ?? .notFound
        static let gray = UIColor.init(named: "Gray") ?? .notFound
        static let brightGray = UIColor.init(named: "Bright Gray") ?? .notFound
        static let middleGray = UIColor.init(named: "Middle Gray") ?? .notFound
        static let darkGray = UIColor.init(named: "Dark Gray") ?? .notFound
        static let deepGray = UIColor.init(named: "Deep Gray") ?? .notFound
        static let background = UIColor.init(named: "Background") ?? .notFound
        static let blue = UIColor.systemBlue
    }
    
    struct Asset {
        
        static let square = UIImage(named: "Square") ?? UIImage()
    }
}


extension UIColor {
    
    static let notFound = UIColor.magenta
}
