//
//  ScrollToResponderViewController.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 07/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


class ScrollToResponderViewController: UIViewController {
    
    lazy var emailTextField = UITextField()
        .withEmailStyle
        .with(next: givenNameTextField)
    
    lazy var givenNameTextField = UITextField()
        .withGivenNameStyle
        .with(next: familyNameTextField)
        
    lazy var familyNameTextField = UITextField()
        .withFamilyNameStyle
        .with(next: passwordTextField)
    
    lazy var passwordTextField = UITextField()
        .withPasswordStyle
    
    lazy var textFields = UIStackView()
        .vertical(spacing: UI.spacing)
        .views(
            emailTextField,
            givenNameTextField,
            familyNameTextField,
            passwordTextField
        )
    
    lazy var wrappedScrollView = UIView()
        .with {
            $0.addSubview(
                UIScrollView()
                    .withBorderedStyle
                    .with {
                        $0.addSubview(textFields)
                    }
                    .onMoveToSuperview { scrollView, superview in
                        scrollView.pin(to: superview)
                        self.textFields.pin(to: scrollView, insets: .init(top: 0, left: 10, bottom: 0, right: 10))
                        self.textFields.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20).isActive = true
                    }
            )
            $0.addSubview(UIView().withTopCoverStyle)
            $0.addSubview(UIView().withBottomCoverStyle)
        }
        .onMoveToSuperview {
            $0.set(height: 160) // 10 + 56 + 5 + 56 + 5 + 56 / 2
            // $0.set(height: 259) // 10 + 56 + 5 + 56 + 5 + 56 + 5 + 56 + 10
        }
    
    lazy var body = UIStackView()
        .vertical(spacing: 10)
        .views(
            UIView()
                .onMoveToSuperview {
                    $0.set(height: 89) // 56 + 5 + 56 / 2
                },
            wrappedScrollView,
            UIView.spacer
        )
        .onMoveToSuperview {
            $0.pin(to: self.view.safeAreaLayoutGuide, insets: .padding)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(body)
        view.backgroundColor = .systemBackground
    }
}


extension UIEdgeInsets {
    
    static let padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
}


extension UIScrollView {
    
    var withBorderedStyle: Self {
        with {
            $0.contentInset = .init(top: 10, left: 0, bottom: 10, right: 0)
            $0.layer.borderColor = UI.Color.label.withAlphaComponent(0.5).cgColor
            $0.layer.cornerRadius = 4
            $0.layer.borderWidth = 1
            $0.clipsToBounds = false
        }
    }
}


extension UIView {
    
    var withTopCoverStyle: Self {
        with {
            $0.backgroundColor = UI.Color.background.withAlphaComponent(0.6)
        }
        .onMoveToSuperview { view, superview in
            view.set(height: 500)
            view.topAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        }
    }
    
    var withBottomCoverStyle: Self {
        with {
            $0.backgroundColor = UI.Color.background.withAlphaComponent(0.6)
        }
        .onMoveToSuperview { view, superview in
            view.set(height: 500)
            view.bottomAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        }
    }
}
