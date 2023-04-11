## [Defining custom patterns](https://www.swiftbysundell.com/articles/defining-custom-patterns-in-swift/)

```swift
func ~=<T>(lhs: KeyPath<T, Bool>, rhs: T?) -> Bool {
    rhs?[keyPath: lhs] ?? false
}

func testExample() throws {
    
    let text = "Some text"
    switch text.first {
    case \.isNumber:
        print("Number")
        break
    case \.isLetter:
        print("Letter")
        break
    default:
        print("No number, no letter")
        break

    }
}
```

