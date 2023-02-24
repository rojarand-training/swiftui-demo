## [Dynamic Member Lookup](https://www.swiftbysundell.com/tips/building-an-observable-type-for-swiftui-views/)

[hackingwithswift](https://www.hackingwithswift.com/articles/55/how-to-use-dynamic-member-lookup-in-swift)


The `@dynamicMemberLookup` feature let you write Swift in the way you would expect from languages like JavaScript or Python keeping is strong typing safety.

The `@dynamicMemberLookup` property wrapper requires the `subscript` to be implemented in the wrapped class.
```console
@dynamicMemberLookup attribute requires 'Observalble' to have a 'subscript(dynamicMember:)' method that accepts either 'ExpressibleByStringLiteral' or a key path
```

```swift
@dynamicMemberLookup
final class Observalble<Value>: ObservableObject {
    
    @Published var value: Value
    private var cacellable: AnyCancellable?
    
    init<P: Publisher>(value: Value, publisher: P) where P.Output == Value, P.Failure == Never {
        self.value = value
        self.cacellable = publisher.assign(to: \.value, on: self)
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<Value, T>) -> T {
        value[keyPath: keyPath]
    }
}
```

<img src="preview.gif">
