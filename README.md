## [Show how to hierarchically paint SF symbols](https://www.hackingwithswift.com/quick-start/swiftui/how-to-get-custom-colors-and-transparency-with-sf-symbols)

```swift
VStack {
    Text(".symbolRenderingMode(.hierarchical)")
        .font(.system(size: 12))
    
    Image(systemName: "theatermasks")
        .foregroundColor(.orange)
        .symbolRenderingMode(.hierarchical)
        .font(.system(size: 64))
}.padding(10)
```

<img src="preview.png" width="40%" >
