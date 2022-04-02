#  Keyboard Avoidance

Keyboard avoidance in ✌️ 2 lines of code. Animate to text fields (or any responder), swipe down keyboard dismissal for free.

> More streamlined examples soon.


## How

1. Put everything in a scroll view.
2. Pin the bottom of the scroll view to the top of the `keyboardLayoutGuide`.
3. Set `keyboardDismissMode` to `.onDrag`.

```Swift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Views.
        let titleLabel = UILabel()
        titleLabel.text = "Sign Up"
        
        let firstNameTextField = UITextField()
        firstNameTextField.placeholder = "First Name"
        
        let lastNameTextField = UITextField()
        lastNameTextField.placeholder = "Last Name"
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(firstNameTextField)
        stack.addArrangedSubview(lastNameTextField)
        
        let wireframe = WireframeView()
        wireframe.backgroundColor = .clear
        wireframe.alpha = 0.5
        wireframe.isUserInteractionEnabled = false
        
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.clipsToBounds = false
        scrollView.keyboardDismissMode = .onDrag // 💎
        
        // Hierarchy.
        scrollView.addSubview(wireframe)
        scrollView.addSubview(stack)
        view.addSubview(scrollView)
                
        // Constraints.
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: 0).isActive = true // 💎
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        
        wireframe.translatesAutoresizingMaskIntoConstraints = false
        wireframe.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        wireframe.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        wireframe.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        wireframe.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        stack.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        stack.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        stack.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
        // Vertical scrolling.
        stack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0).isActive = true
    }
}
```


## License

> Licensed under the [**MIT License**](https://en.wikipedia.org/wiki/MIT_License).
