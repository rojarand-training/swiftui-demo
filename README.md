## [Show how to render markdown content in text](https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-markdown-content-in-text)

```swift
struct ContentView: View {

    private let stringIsNotMarkdown: String = "I'm plain string so not a **markdown** *string*."
    private let localizedStringIsMarkdown: LocalizedStringKey = "I'm **localized string**."
    
    var body: some View {
        VStack {
            
            Text("I'm a **markdown** *string*. [Google](www.google.com)")
            Text(verbatim: "I'm not a **markdown** *string*.")
            Text(stringIsNotMarkdown)
            Text(localizedStringIsMarkdown)
        }
    }
}
```

<img src="preview.png" width="40%" >
