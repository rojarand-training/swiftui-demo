## Gradient animation example

Unfortunately `keypath` is a string. Note that the gradient must have frame set. 

```swift
override func viewDidLoad() {
        super.viewDidLoad()
           
        let iView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        iView.center = view.center
        iView.backgroundColor = .yellow
        view.addSubview(iView)
        
        let gradientLayer = CAGradientLayer(layer: iView.layer)
        gradientLayer.locations = [0, 1] //- 1
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = iView.bounds //- 2
        iView.layer.insertSublayer(gradientLayer, at: 0)
        
        let animation = CABasicAnimation(keyPath: "locations") //- 1
        animation.fromValue = [0.0, 0.2]
        animation.toValue = [0.0, 0.9]
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        gradientLayer.add(animation, forKey: nil)
    }
```

<img src="preview.gif">
