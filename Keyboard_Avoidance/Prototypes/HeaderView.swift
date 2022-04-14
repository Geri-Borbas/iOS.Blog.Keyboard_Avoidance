//
//  HeaderView.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 11/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


class HeaderView: UIView {
    
    lazy var topSpacer = UIView.spacer
    
    lazy var scribble = UIImageView().withScribbleStyle
    
    lazy var bottomSpacer = UIView.spacer
        .onMoveToSuperview {
            $0.heightAnchor.constraint(equalTo: self.topSpacer.heightAnchor).isActive = true
        }
    
    lazy var body = UIStackView()
        .vertical(spacing: 0)
        .views(
            topSpacer,
            scribble,
            UILabel().withHeaderStyle,
            bottomSpacer
        )
        .with {
            $0.setCustomSpacing(-30, after: scribble)
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(body)
        body.translatesAutoresizingMaskIntoConstraints = false
        body.topAnchor.constraint(equalTo: topAnchor).isActive = true
        body.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        body.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        body.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HeaderView {
    
    var withFixedHeight: Self {
        onMoveToSuperview {
            let screenHeight = UIScreen.main.bounds.height
            let itemsHeight = UI.itemHeight * 5 + UI.spacing * 4
            let safeAreaHeight = UIApplication.firstWindow?.safeAreaInsets.verticalInsets ?? CGFloat(0)
            let headerHeight = screenHeight - itemsHeight - safeAreaHeight
            $0.set(height: headerHeight)
        }
    }
}


extension UIEdgeInsets {
    
    var verticalInsets: CGFloat {
        top + bottom
    }
}


extension UIImageView {
    
    var iconName: String {
        if #available(iOS 14.0, *) {
            return "scribble.variable"
        } else {
            return "pencil.and.outline"
        }
    }
    
    var withScribbleStyle: Self {
        with(
            image: UIImage(
                systemName: iconName,
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 96,
                    weight: .light
                )
            )
        )
            .with {
                $0.tintColor = UI.Color.gray
                $0.contentMode = .center
            }
    }
}


extension UILabel {
    
    var withHeaderStyle: Self {
        with {
            $0.text = "Sign up"
            $0.font = UIFont.rounded(size: 64, weight: .heavy)
            $0.textAlignment = .center
            $0.textColor = UI.Color.label
        }
    }
}
