## [UIKit trait system](https://developer.apple.com/videos/play/wwdc2023/10057/)

[stackoveflow](https://stackoverflow.com/questions/77199403/is-it-possible-to-change-a-custom-trait-from-a-parent-trait-collection-and-obser)

We can define traits that are passed down to child views in the hierarchy.

```swift
struct TextCapitalizationTrait: UITraitDefinition {
    static var defaultValue = false
}

extension UITraitCollection {
    var useBoldText: Bool {
        get {
            self[TextCapitalizationTrait.self]
        }
    }
}

extension UIMutableTraits {
    var useBoldText: Bool {
        get {
            self[TextCapitalizationTrait.self]
        }
        set {
            self[TextCapitalizationTrait.self] = newValue
        }
    }
}

class MyLabel: UILabel {
    override var text: String? {
        get { super.text }
        set {
            super.text = traitCollection.useBoldText ? newValue?.uppercased() : newValue
        }
    }
}

class MyViewController: UIViewController {
    
    private let label = MyLabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        ...
        traitOverrides.useBoldText = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        label.text = "Hello"
    }
}
```

<img src="preview.png" width="40%" >
