## [Debugging what causes body recreation](https://www.hackingwithswift.com/quick-start/swiftui/how-to-find-which-data-change-is-causing-a-swiftui-view-to-update)

Use `Self._printChanges()` to print source of body recreation.

```swift
struct InnerView: View {
    
    var body: some View {
        composeBody()
    }
    
    @ViewBuilder func composeBody() -> some View {
        let _ = Self._printChanges()
        Text("I'm inner view")
    }
}
```

<img src="preview.gif">
