## [Show how to create 3d effects like cover flow using scrollview and geometryreader
](https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-3d-effects-like-cover-flow-using-scrollview-and-geometryreader)

```swift
var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack {
            ForEach(1..<20) { i in
                VStack {
                    GeometryReader { geo in
                        Text("Item: \(i)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            
                            .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).minX) / 8), axis: (x: 0, y: 1, z: 0))
                            .frame(width: 200, height: 200)
                    }.frame(width: 200, height: 200)
                }
            }
        }
    }
}
```

<img src="preview.gif" width="40%" >
