## [Preference Key example](https://swiftwithmajid.com/2020/01/15/the-magic-of-view-preferences-in-swiftui/)


SwiftUI has the environment concept which we can use to pass data down into a view hierarchy. But sometimes we need to **pass data up** from child view to the parent view, and this is **where preferences shine**.

```swift
struct BackgroundColorPreferenceKey: PreferenceKey {
    static var defaultValue: Color { .clear }
    static func reduce(value: inout Self.Value, nextValue: () -> Self.Value) {
        value = nextValue()
    }
}

struct BackgroundView<Content: View>: View {

    @State var bgColor = BackgroundColorPreferenceKey.defaultValue
    let content: () -> Content
    init(content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
            .background(bgColor)
            .onPreferenceChange(BackgroundColorPreferenceKey.self) { color in
                bgColor = color
            }
    }
}
```

<img src="preview.gif" width="40%" >
