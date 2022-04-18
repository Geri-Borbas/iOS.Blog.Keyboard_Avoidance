# Keyboard Avoidance

Keyboard avoidance with a single line of code. Animate to text fields (or any responder), swipe down keyboard dismissal for free. See the corresponding article for more [Keyboard Avoidance with a single line of code], also on detail how to backport `keyboardLayoutGuide` to iOS 13 and iOS 14.

https://user-images.githubusercontent.com/1779614/163884587-c11f4953-2f30-4b46-b36f-1fac9b32a017.mp4

## How

1. Put everything in a scroll view.
2. Pin the bottom of the scroll view to the top of the `keyboardLayoutGuide`.
3. Set `keyboardDismissMode` to `.onDrag`.

```Swift
class ViewController: UIViewController {
    
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
    
    lazy var signUpButton = UIButton()
        .withSignUpButtonStyle
    
    lazy var content = UIStackView()
        .vertical(spacing: UI.spacing)
        .views(
            HeaderView()
                .withFixedHeight,
            emailTextField,
            givenNameTextField,
            familyNameTextField,
            passwordTextField,
            signUpButton
        )
    
    lazy var body = UIScrollView()
        .with {
            $0.addSubview(content)

            // 💎
            $0.keyboardDismissMode = .onDrag
            $0.bounces = false
        }
        .onMoveToSuperview { scrollView in
            self.content.pin(to: scrollView)
            self.content.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Hierarchy.
        view.addSubview(body)
        body.translatesAutoresizingMaskIntoConstraints = false
        body.topAnchor.constraint(equalTo: view.topAnchor, constant: UI.padding).isActive = true

        // 💎
        body.bottomAnchor.constraint(
            equalTo: view.keyboardLayoutGuide.topAnchor,
            constant: -UI.spacing
        ).isActive = true

        body.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: UI.spacing).isActive = true
        body.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -UI.spacing).isActive = true
    }
}
```

> The example above uses [`Withable`], a simple inline decorator that helps simplify your `UIKit` code.


## License

> Licensed under the [**MIT License**](https://en.wikipedia.org/wiki/MIT_License).


[Keyboard Avoidance with a single line of code]: https://blog.eppz.eu/keyboard-avoidance/
[`Withable`]: https://github.com/Geri-Borbas/iOS.Package.Withable
