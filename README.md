## Simple animation example

Note!!!. If a variable is outside of the `withAnimation` block, then animation does not respect animation configuration.

```swift
//Wrong:
Button {
    enableRedButtonRoundedCorners.toggle()
    withAnimation(.easeIn(duration: 3)) {
        
    }
}
//Ok:
Button {
    withAnimation(.easeIn(duration: 3)) {
        enableBlueButtonRoundedCorners.toggle()
    }
}
```

<img src="preview.gif">
