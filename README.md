## Advanced Combine convenience method

```swift
extension Publisher {
    func unwrap<T, E: Error>(orThrow error: @escaping @autoclosure () -> E) -> Publishers.TryMap<Self, T>
    where Output==Optional<T> {
        return tryMap { output in
            switch output {
            case .some(let value):
                return value
            default:
                throw error()
            }
        }
    }
}

func compute() {
    cancellable = Just<Int?>( drawEvenNumber() )
        .unwrap(orThrow: UnexpectedNilReceived())
        .sink { result in
            self.resultDescription = "Result: \(result)"
        } receiveValue: { value in
            self.resultValue = "\(value)"
        }
}
```

<img src="preview.gif">
