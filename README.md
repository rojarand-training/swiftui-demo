## [Custom environment variable](https://useyourloaf.com/blog/swiftui-custom-environment-values/)

```swift
// 1. Create the key with a default value
struct CustomBackgroundColor: EnvironmentKey {
    static var defaultValue: Color = .red
}

// 2. Extend the environment with our property
extension EnvironmentValues {
    var cbc: Color {
        get { self[CustomBackgroundColor.self] }
        set { self[CustomBackgroundColor.self] = newValue }
    }
}

struct ContentView: View {

    var body: some View {
        VStack {
            Parent(text: "No bg color defined")
            Parent(text: "Bg color defined")
                .environment(\.cbc, .blue)
        }
    }
}
```

<img src="preview.png" width="40%" >
