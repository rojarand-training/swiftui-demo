## [Text concatenation  with mixed styling in SwiftUI](https://www.swiftbysundell.com/questions/swiftui-text-mixed-styles/)

```swift
struct ContentView: View {
    
    let colors: [Color] = [.yellow, .red, .blue, .brown]
    
    var body: some View {
        VStack {
            HStack {
                Text("Hello").bold().foregroundColor(.blue)
                Text("World").italic().foregroundColor(.red)
            }
            Text("Hello").bold().foregroundColor(.blue) +
            Text("World").italic().foregroundColor(.red)
           
            colors.reduce(Text("")) { partialResult, color in
                partialResult + Text("Hello").foregroundColor(color)
            }
        }
    }
}
```

<img src="preview.png" width="40%" >
