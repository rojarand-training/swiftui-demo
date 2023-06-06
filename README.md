## [Dynamic/partial painting of SF Symbols](https://www.hackingwithswift.com/quick-start/swiftui/how-to-dynamically-adjust-the-color-of-an-sf-symbol)

```swift
@State var variableValue = 0.5
var body: some View {
    VStack {
        HStack {
            Image(systemName: "aqi.low", variableValue: variableValue)
            Image(systemName: "wifi", variableValue: variableValue)
            Image(systemName: "chart.bar.fill", variableValue: variableValue)
            Image(systemName: "waveform", variableValue: variableValue)
            
        }
        .foregroundColor(.red)
        Slider(value: $variableValue)
            .padding(10)
    }
}
```

<img src="preview.gif" width="40%" >
