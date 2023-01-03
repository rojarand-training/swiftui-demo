## [Just](https://developer.apple.com/documentation/combine/just) example

A publisher that emits an output to each subscriber **just once**, and then finishes.

You can use a Just publisher to **start a chain of publishers**. A Just publisher is also useful when replacing a value with Publishers.Catch.

In contrast with Result.Publisher, a Just publisher can’t fail with an error. And unlike Optional.Publisher, a Just publisher always produces a value.

```swift
class ContentViewModel: ObservableObject {
    
    @Published var randomValue: Int = 0
    
    private var cancellables: Set<AnyCancellable> = []
    
    func generateRandomValue() {
        //Starts delayed random value generation
        Just<Int>(Int.random(in: 0...100))
            .delay(for: 1, scheduler: RunLoop.main)
            .sink { random in
                self.randomValue = random
            }.store(in: &cancellables)
    }
}
```

<img src="preview.gif">
