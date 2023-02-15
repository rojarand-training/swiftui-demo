## Dynamic type

Note! `accessibility5` is larger than `accessibility1` and `xxxLarge`

```swift
struct ContentView: View {

    var body: some View {
        VStack {
            VStack {
                Text(".xxxLarge - font default")
                Text(".xxxLarge - font title")
                    .font(.title)
            }.environment(\.dynamicTypeSize, .xxxLarge)
            VStack {
                Text(".small - font default")
                Text(".small - font title")
                    .font(.title)
            }.environment(\.dynamicTypeSize, .small)
                .background(.gray)
            VStack {
                Text(".accessibility1 - font default")
                Text(".accessibility1 - font title")
                    .font(.title)
            }.environment(\.dynamicTypeSize, .accessibility1)

            VStack {
                Text(".accessibility5 - font default")
                Text(".accessibility5 - font title")
                    .font(.title)
            }.environment(\.dynamicTypeSize, .accessibility5)
                .background(.gray)
        }
    }
}
```

<img src="preview.png" width="40%" >
