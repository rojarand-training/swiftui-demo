## [How to make two views the same width or height](https://www.hackingwithswift.com/quick-start/swiftui/how-to-make-two-views-the-same-width-or-height)

On iOS, the key is to give each view you want to size an infinite maximum height or width, which will automatically make it stretch to fill all the available space. You then apply `fixedSize()` to the container they are in, which tells SwiftUI those **views should only take up the space they need**.

```swift
VStack {
    Button("Sign in") {}
        .padding()
        .frame(maxWidth: .infinity)
        .background(.green)
        .foregroundColor(.white)
        .clipShape(Capsule())
    Button("Create a new account") {}
        .padding()
        .frame(maxWidth: .infinity)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Capsule())
}
.fixedSize(horizontal: true, vertical: false)
```

<img src="preview.png" width="40%" >
