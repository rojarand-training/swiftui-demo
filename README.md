## [Encapsulating SwiftUI styles](https://www.swiftbysundell.com/articles/encapsulating-swiftui-view-styles/)

```swift
struct RoundedCornersButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let foregroundCGColor = CGColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        let forgroundRGBA = foregroundCGColor.components!
        let pressedForegroundCGColor = CGColor(red: forgroundRGBA[0], green: forgroundRGBA[1], blue: forgroundRGBA[2], alpha: forgroundRGBA[3]*0.75)
        let foregroundColor = Color(cgColor: foregroundCGColor)
        let foregroundColorPressed = Color(cgColor: pressedForegroundCGColor)
        
        let borderCGColor = CGColor(red: 0.0, green: 0.2, blue: 0.75, alpha: 1.0)
        let borderRGBA = borderCGColor.components!
        let borderCGColorPressed = CGColor(red: borderRGBA[0], green: borderRGBA[1], blue: borderRGBA[2], alpha: borderRGBA[3]*0.75)

        let borderColor = Color(cgColor: borderCGColor)
        let borderColorPressed = Color(cgColor: borderCGColorPressed)
        return configuration.label
            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            .foregroundColor(configuration.isPressed ? foregroundColorPressed : foregroundColor)
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(configuration.isPressed ? borderColorPressed : borderColor, lineWidth: 2))
            .cornerRadius(8)
    }
}

struct ContentView: View {

    var body: some View {
        Button("Hello World") {
            print("Button Clicked")
        }.buttonStyle(RoundedCornersButtonStyle())
    }
}
```

<img src="preview.gif">
