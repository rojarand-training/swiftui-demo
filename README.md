## [How to customize the way links are opened](https://www.hackingwithswift.com/quick-start/swiftui/how-to-customize-the-way-links-are-opened)

```swift
struct ContentView: View {

    var body: some View {
        VStack(spacing: 10) {
            Text("[Visit Apple](https://apple.com)")
            Link("Visit Apple", destination: URL(string: "https://apple.com")!)
        }.environment(\.openURL, OpenURLAction(handler: handleURL))
    }
    
    func handleURL(_ url: URL) -> OpenURLAction.Result {
        NSLog("URL to handle: \(url)")
        return .handled
    }
}
```
