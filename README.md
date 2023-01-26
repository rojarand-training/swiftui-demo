## View controller custom initializer. Based on [Swiftbysundell](https://www.swiftbysundell.com/tips/handling-view-controllers-that-have-custom-initializers/)

```swift
class ProductViewController: UIViewController {
    private let product: Product
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)//call super
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Can not create the ProductViewController from a story board")
    }
    ...
}
```

