## Binding example

```swift
struct ContentView: View {

    @State var text: String = "Text"
    var body: some View {
        NavigationView {
            VStack {
                Text("I'm a parent view")
                    .foregroundColor(.red)
                Text(text)
                //We can retrieve binding (projected value of a state) by prefixing the property variable with a dollar sign (`$`) 
                NavigationLink(destination: EditingView(text: $text)) {
                    Text("Click to edit text")
                }
            }
        }
    }
}

struct EditingView: View {
    @Binding var text: String
    var body: some View {
        VStack {
            Text("I'm a child view")
                    .foregroundColor(.red)
            TextField("Edit me", text: $text)
                .frame(width: 150)
        }
    }
}
```

<img src="preview.gif" >
