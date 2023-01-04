## Memory leak free assing

```swift
extension Publisher where Failure==Never {
    func weakAssign<T: AnyObject>(
        to kp: ReferenceWritableKeyPath<T, Output>,
        on object: T) -> AnyCancellable {
        
        sink { [weak object] value in
            object?[keyPath: kp] = value
        }
    }
}

class ContentViewModel: ObservableObject {
    
    @Published var currentDate: String = ""
    private var cancellables: AnyCancellable?
    
    func updateDate() {
        cancellables = Just<Date>(Date.now)
            .map{ "\($0)" }
            .weakAssign(to: \.currentDate, on: self)
    }
}
```

<img src="preview.gif">
