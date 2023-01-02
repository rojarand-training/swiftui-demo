## `propertyWrapper` example

Details can be found here: https://www.swiftbysundell.com/tips/property-wrapper-default-values/

```swift
@propertyWrapper struct Capitalized {
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.capitalized }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}

struct ContentView: View {

    @State @Capitalized var text = "hello world"
    var body: some View {
        Text(text)
        Button("Change text") {
            text = "hello universe"
        }
    }
}
```

<img src="preview.gif">
