## WeakWrapper example

The following contruct can be used to avoid memory leaks caused by retain cycles and in the same time avoiding using `?` unwrapping operator. 
```swift
@propertyWrapper struct WeakWrapper<T:AnyObject> {
    
    weak var weakValue: T?
    
    var wrappedValue: T {
        set {
            weakValue = newValue
        }
        get {
            weakValue!
        }
    }
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}
```

Without the `WeakWrapper` we would need to access variable using the following contruct:

```swift
func generateTextSync() {
    let randomNumber = Int.random(in: (1...100))
    textView?.show(text: "\(randomNumber)")
}
```

With `WeakWrapper`:
```swift
@WeakWrapper var textView: TV
...

func generateTextSync() {
    let randomNumber = Int.random(in: (1...100))
    textView.show(text: "\(randomNumber)")
}
```
