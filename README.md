## [Combine Scan](https://paigeshin1991.medium.com/swift-combine-scan-method-the-most-useful-operator-fae10bc8debf)

The `scan` operator of combine acts as Swift's `reduce`. It aggregates history of updates.

```swift
final class ContentViewModel: ObservableObject {
    
    @Published var history: String = ""
    var currentText: String = ""
    
    private var subject = CurrentValueSubject<String, Error>("")
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = subject
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .filter({ string in
                string.count > 1
            })
            .scan("") { nextPartialResult, newString in
            nextPartialResult + "\n "+newString
        }.sink(receiveCompletion: { completion in
            
        }, receiveValue: { string in
            self.history = string
        })
    }
    
    func updateCurrentText(newText: String) {
        currentText = newText
        subject.send(newText)
    }
}
```

<img src="preview.gif">
