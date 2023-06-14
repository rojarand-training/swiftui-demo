## [Show how to place content in safe area](https://www.hackingwithswift.com/quick-start/swiftui/how-to-inset-the-safe-area-with-custom-content)

```swift
var body: some View {
    NavigationStack {
        List {
            ForEach(1..<20) { index in
                Text("Row: \(index)")
            }
        }
        .navigationTitle("Select a row")
        .safeAreaInset(edge: .bottom) {
            Text("Hello I'am the very bottom view")
                .frame(maxWidth: .infinity)
                .background(.yellow)
        }
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            Button {
                print("Help tapped")
            } label: {
                Image(systemName: "info.circle.fill")
                    .font(.largeTitle)
                    .symbolRenderingMode(.multicolor)
                    .padding(.trailing)
            }
        }
    }
}
```

<img src="preview.gif" width="40%" >
