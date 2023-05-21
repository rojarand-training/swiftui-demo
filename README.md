## [Show how to trim shapes](https://www.hackingwithswift.com/quick-start/swiftui/how-to-draw-part-of-a-solid-shape-using-trim)

```swift
VStack {
    ZStack {
        Circle()
            .trim(from: 0.0, to: 0.5)
            .fill(.blue)
            .frame(width: 100, height: 100)
        Text("trim(from: 0.0, to: 0.5)")
    }
    ZStack {
        Circle()
            .trim(from: 0.0, to: 0.75)
            .fill(.blue)
            .frame(width: 100, height: 100)
        Text("trim(from: 0.0, to: 0.75)")
    }
}
```

<img src="preview.gif" >
