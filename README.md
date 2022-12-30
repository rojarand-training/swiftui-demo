## Padding example

```swift
struct ContentView: View {

    var body: some View {
        ZStack {
            Color(.red)
                .ignoresSafeArea()
            Text("Hello World")
                    .padding(.top, 30)
                    .padding(.leading, 50)
                    .background(.white)
        }
    }
}
```

<img src="preview.png" width="50%" >