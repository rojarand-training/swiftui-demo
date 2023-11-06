## Dispatch Work Item
https://betterprogramming.pub/a-deep-dive-into-dispatchworkitem-274548357dea

> The `notify` method is called despite an instance of DispatchWorkItem finished execution or not (has been cancelled)

```swift
final class ContentViewModel: ObservableObject {
    
    @Published var result: String = ""
    @Published var status: String = ""
    
    private var workItem: DispatchWorkItem?
    
    func run() {
        workItem?.cancel()
        let newWorkItem = DispatchWorkItem() { [weak self] in
            self?.result = "Success"
        }
        newWorkItem.notify(queue: .main) { [weak self] in
            self?.status = newWorkItem.isCancelled ? "CANCELLED" : "FINISHED"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: newWorkItem)
        workItem = newWorkItem
    }
}
```

<img src="preview.gif" width="40%" >
