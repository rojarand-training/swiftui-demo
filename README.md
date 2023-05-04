## [How to display solid shapes](https://www.hackingwithswift.com/quick-start/swiftui/how-to-display-solid-shapes)

```swift
Circle()
    .fill(.red)
    .frame(width: 100)

Rectangle()
    .fill(.green)
    .frame(width: 200, height: 100)

RoundedRectangle(cornerRadius: 20)
    .fill(.orange)
    .frame(width: 200, height: 100)

Capsule(style: .continuous)
    .fill(.blue)
    .frame(width: 200, height: 100)
```

<img src="preview.png" width="40%" >
