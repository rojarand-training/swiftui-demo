## Text example

```swift
struct PersistentCounterView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    var body: some View {
        ...
    }
}

struct VolatileCounterView: View {
    
    @ObservedObject private var viewModel = ContentViewModel()
    var body: some View {
        ...
    }
}

struct ContentView: View {
    
    @ObservedObject private var viewModel = ContentViewModel()
    @State var randomNumber = 0

    var body: some View {
        VStack {
            Text("Active: \(randomNumber)")
            Button {
                randomNumber = (0..<1000).randomElement() ?? 0
            } label: {
                Text("Reset view")
            }
            PersistentCounterView()
            VolatileCounterView()
        }
    }
}
```

<img src="preview.gif">
