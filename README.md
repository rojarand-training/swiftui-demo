## Using UIViewControllers in SwiftUI

> Note!!! To use `UIViewController` inside SwiftUI you must implement `UIViewControllerRepresentable` not `UIViewRepresentable`.

```swift
struct ContentView: View {

    var body: some View {
        UIViewRepresentation()
    }
}

struct UIViewRepresentation: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> SampleViewController {
        return SampleViewController()
    }
    
    func updateUIViewController(_ uiViewController: SampleViewController, context: Context) {
    }
}
```

<img src="preview.png" width="40%" >
