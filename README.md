## Combine zip example

```swift
final class ContentViewModel: ObservableObject {
    private var cancellableSet: Set<AnyCancellable> = []
    @Published var randomValue: String = ""
    
    private var integerGenerator = PassthroughSubject<Int, Never>()
    private var stringGenerator = PassthroughSubject<String, Never>()
    
    init() {
        
        let delayedStringGenerator = stringGenerator
            .delay(for: 1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
        
        integerGenerator.zip(delayedStringGenerator)
            .sink { (generatedInteger, generatedString) in
                self.randomValue = "\(generatedInteger) - \(generatedString)"
            }
            .store(in: &cancellableSet)
    }
    
    func generate() {
        integerGenerator.send(generateInteger())
        stringGenerator.send("\(generateInteger())")
    }
    
    private func generateInteger() -> Int {
        return (1...1000).randomElement() ?? 0
    }
}
```

<img src="preview.gif">
