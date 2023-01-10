## Cancelling task example

[Swift By Sundell](https://www.swiftbysundell.com/articles/the-role-tasks-play-in-swift-concurrency)

```swift
class ViewModel: ObservableObject {
    private var task: Task<(), Error>?
    
    func waitAndPrintHello() {
        task = Task {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            print("Hello")
        }
    }
    
    func cancel() {
        task?.cancel()
        task = nil
    }
}
```
