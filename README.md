## Combine Just/Faile example

`.setFailureType(to: ErrorType)` allows to convert just to a failable publisher.

```swift
class ContentViewModel: ObservableObject {
    
    func multiply(value: Int) -> AnyPublisher<Int, Error> {
        guard value>0 else {
            return Fail(error: PositiveIntRequired()).eraseToAnyPublisher()
        }
        /*Cannot convert return expression of type 'AnyPublisher<Int, Never>' to return type 'AnyPublisher<Int, any Error>'
        return Just(value*2).eraseToAnyPublisher()
         */
        
        return Just(value*2)
            .setFailureType(to: Error.self) //we need to specify failure type
            .eraseToAnyPublisher()
    }
}
```

<img src="preview.gif" width="40%" >
