## [Call as function](https://www.swiftbysundell.com/articles/exploring-swift-5-2s-new-functional-features/) 

```swift
struct FullName {
    let value: String
}

extension FullName {
    func callAsFunction() -> String {
        self.value
    }
}

let initializedFullName: FullName(value: "robert andrzejczyk")
initializedFullName() <<<<------
```

<img src="preview.png" width="40%" >
