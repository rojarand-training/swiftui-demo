## [Wrapping UIView](https://www.swiftbysundell.com/tips/inline-wrapping-of-uikit-or-appkit-views-within-swiftui/)

```swift
struct UIViewWrapper<V: UIView>: UIViewRepresentable {
    
    private let viewMaking: () -> V
    private let viewUpdating: (V, Context) -> Void
    
    init(viewMaking: @escaping () -> V,
         viewUpdating: @escaping (V, Context) -> Void) {
        
        self.viewMaking = viewMaking
        self.viewUpdating = viewUpdating
    }
    
    func makeUIView(context: Context) -> V {
        viewMaking()
    }
    
    func updateUIView(_ uiView: V, context: Context) {
        viewUpdating(uiView, context)
    }
}
```

<img src="preview.gif" width="40%" >
