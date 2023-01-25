## Based on [article 1](https://www.swiftbysundell.com/tips/showing-view-controllers/), [article 2](https://www.swiftbysundell.com/tips/showing-view-controllers/)

```swift
extension UIViewController {
    
    func add(_ childViewController: UIViewController) {
        self.view.addSubview(childViewController.view)
        childViewController.willMove(toParent: self)
        self.addChild(childViewController)
        childViewController.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        self.willMove(toParent: nil)
        self.removeFromParent()
        self.didMove(toParent: nil)
        self.view.removeFromSuperview()
    }
}
```

<img src="preview.gif">
