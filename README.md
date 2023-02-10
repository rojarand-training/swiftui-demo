## [Loading view from xib](https://rebekkaorthdev.medium.com/a-guide-to-loading-nibs-2a9f7808b531)

1. Create a custom IUView class
- Xcode/cmd+n/(Source section)Cocoa Touch Class

2. Create xib 
- Xcode/cmd+n/(User interface section)View
- In inspector select: Simulated Metrics/Size = Freeform

> Note !!! A view class **has to set for a view owner** not for a view itself. Otherwise an app will crash.

<img src="preview.png" width="80%" >

```swift
final class CustomUIView: UIView {
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        guard let view = loadView() else { return }
        view.frame = view.bounds
        self.addSubview(view)
        label.text = "I'am loaded"
    }
    
    private func loadView() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomUIView", bundle: bundle)
        return nib.instantiate(withOwner: self).first as? UIView
    }
}
```


