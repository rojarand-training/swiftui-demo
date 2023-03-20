## [Advanced layout positioniong and sizing](https://www.swiftbysundell.com/articles/swiftui-layout-system-guide-part-3/)

For andvanced laupout management you can use: `layoutPriority` and frame `frame` modifiers.

```swift
struct Page4: View {
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink("Go to page 5") {
                Page5()
            }
            EventHeader(title: "Image placeholder layoutPriority=-1 + minHeight=100")
            Text(test1)
                .font(.title3)
            ImagePlaceholder()
                .layoutPriority(-1)
                .frame(minHeight: 100)
            Text(test2)
            Spacer()
            EventInfoList()
        }.padding(5)
    }
}
```

<img src="preview.gif" >
