## Slider example

```swift
struct ContentView: View {

    @State private var sliderValue: Double = 0
    var body: some View {
        VStack {
            Slider(value: $sliderValue, in: 0...100)
            Text("Current value: \(sliderValue)")
        }
    }
}
```

<img src="preview.gif">
