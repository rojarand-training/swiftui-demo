## Combine working thread switching example

>> Note!! `receive` must be under a computation otherwise, the computation takes place in in the same thread as receive points to.

```swift
//Wrong:
.subscribe(on: DispatchQueue.global())
.receive(on: DispatchQueue.main)
.map { ... }

//Good
.subscribe(on: DispatchQueue.global())
.map { ... }
.receive(on: DispatchQueue.main)
```

```swift
class NonBlockingRandomStringViewModel: ObservableObject {
    @Published var content: String = ""
    var cancellable: Cancellable?
    
    func regenerate() {
        cancellable = Just(Int.random(in: 1...100))
            .subscribe(on: DispatchQueue.global())
            .map { (generated: Int) in
                print("Inside map, main thread: \(Thread.isMainThread)")
                Thread.sleep(forTimeInterval: 2)
                return generated*2
            }
            .receive(on: DispatchQueue.main)
            .sink { generated in
                print("Inside sink, main thread: \(Thread.isMainThread)")
                self.content = "\(generated)"
            }
    }
}
```

<img src="preview.gif">
