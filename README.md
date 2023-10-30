## autoresizingMask, .flexibleWidth, .flexibleHeight

It is important to remember to set `autoresizingMask` with `.flexibleWidth` and `.flexibleHeight` for a view added with `frame`. Otherwise the view will not stretch properly. By default the `autoresizingMask` array is empty. 

```swift
override func viewDidLoad() {
    let blueBackgroundView = UIView(frame: self.view.bounds)
    blueBackgroundView.backgroundColor = .blue
    blueBackgroundView.translatesAutoresizingMaskIntoConstraints = true
    //---------
    blueBackgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    //---------
    view.addSubview(blueBackgroundView)
    
    let redForegroundView = UIView(frame: self.view.bounds)
    redForegroundView.backgroundColor = .red
    redForegroundView.translatesAutoresizingMaskIntoConstraints = true
    view.addSubview(redForegroundView)

    super.viewDidLoad()
}
```

<img src="preview.gif" width="40%" >
