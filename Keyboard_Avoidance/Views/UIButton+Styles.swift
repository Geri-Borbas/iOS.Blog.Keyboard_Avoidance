//
//  UIButton+Styles.swift
//  Half Modal
//
//  Created by Geri Borbás on 30/03/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


extension UIButton {
    
    var withBaseButtonStyle: Self {
        with { button in
            button.titleLabel?
                .with {
                    $0.font = UIFont.rounded(size: 20, weight: .bold)
                    $0.textAlignment = .center
                    $0.pin(to: button, insets: UIEdgeInsets.zero)
                    $0.set(height: 50)
                }
            button.setTitleColor(UI.Color.label, for: .normal)
            button.setBackgroundImage(
                UI.Asset.square.withTintColor(UI.Color.blue),
                for: .normal
            )
        }
    }
    
    var withButtonStyle: Self {
        withBaseButtonStyle
            .with {
                $0.layer.cornerRadius = 10
                $0.clipsToBounds = true
            }
    }
    
    var withCapsuleButtonStyle: Self {
        withBaseButtonStyle
            .with {
                $0.layer.cornerRadius = 25
                $0.clipsToBounds = true
            }
    }
    
    func with(title: String) -> Self {
        with {
            $0.setTitle(title, for: .normal)
        }
    }
}
