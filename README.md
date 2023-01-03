## View Modifier example

SwiftUI comes with built-in modifiers such as `background` or `padding`, among others. It also gives to ability to create your own custom modifiers. 

```swift
enum ButtonStyle {
    case success
    case failure
    case info
    
    var foregroundColor: Color {
        switch self {
        case .success:
            return .green
        case .failure:
            return .red
        case .info:
            return .blue
        }
    }
}

struct StyledButton: ViewModifier {
    let style: ButtonStyle
    
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .background(style.foregroundColor)
            .cornerRadius(10)
    }
}

extension View {
    func successButton() -> some View {
        return modifier(StyledButton(style: .success))
    }
    
    func failureButton() -> some View {
        return modifier(StyledButton(style: .failure))
    }
    
    func infoButton() -> some View {
        return modifier(StyledButton(style: .info))
    }
}

struct ContentView: View {

    var body: some View {
        
        VStack {
            Button { } label: {
                Text("Success").successButton()
            }
            Button { } label: {
                Text("Failure").failureButton()
            }
            Button { } label: {
                Text("Info").infoButton()
            }
        }
    }
}
```

<img src="preview.png" width="40%" >
