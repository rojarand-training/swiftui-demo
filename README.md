## Show that order of SwiftUI modifiers matters

```swift
struct V1: View{
    
    var body: some View {
        Text("V1")
            .background(.red)
            .padding()
            .border(.blue) <<--- border
    }
}

struct V2: View{
    
    var body: some View {
        Text("V2")
            .background(.red)
            .border(.blue) <<--- border
            .padding()
    }
}
```

This is how composition look like:
- V1
```
ModifiedContent<ModifiedContent<ModifiedContent<Text, _BackgroundStyleModifier<Color>>, _PaddingLayout>, _OverlayModifier<_ShapeView<_StrokedShape<_Inset>, Color>>>
```

- V2
```
ModifiedContent<ModifiedContent<ModifiedContent<Text, _BackgroundStyleModifier<Color>>, _OverlayModifier<_ShapeView<_StrokedShape<_Inset>, Color>>>, _PaddingLayout>
```

<img src="preview.png" width="40%" >
