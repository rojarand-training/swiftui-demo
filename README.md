## Based on [SwiftBySundell](https://www.swiftbysundell.com/tips/observing-combine-publishers-in-swiftui-views/)

```swift
extension View {
    
    func onNotification(withName name: NSNotification.Name, perform action: @escaping () -> Void) -> some View {
        return onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            action()
        }
    }
    
    func onWillEnterForeground(perform action: @escaping () -> Void) -> some View {
        return onNotification(withName: UIApplication.willEnterForegroundNotification,
                              perform: action)
    }
}

struct ContentView: View {

    @State var eventsLog = ""
    var body: some View {
        Text("Events:\n\(eventsLog)")
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                eventsLog += "- Did enter background\n"
            }
            .onWillEnterForeground {
                eventsLog += "- Will enter background\n"
            }
    }
}
```

<img src="preview.gif">
