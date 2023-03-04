## [Onboarding](https://dev.to/domanovdev/swiftui-onboarding-view-1165)

```swift
struct ContentView: View {

    @State private var selection = 1
    
    var body: some View {
        
        TabView(selection: $selection) {
            Text("Tab1")
                .zoomInOnAppear()
                .tag(0)
            
            Text("Tab2")
                .zoomInOnAppear()
                .tag(1)
            
            Text("Tab3")
                .zoomInOnAppear()
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}
```

<img src="preview.gif" width="60%" >
