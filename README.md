## L10n example

https://developer.apple.com/videos/play/wwdc2023/10155

To add a string catalog to your project, choose File > New > File. In the sheet that appears, select the platform, enter string into the filter field, select String Catalog, and click Next. In the dialog that appears, accept the default name Localizable , choose a location, and click Create.

The string catalog is populated during compilation. Make sure you have `Use compiler to Extract Swift Strings` in `Build Settings/Localization`. More info [here](https://developer.apple.com/videos/play/wwdc2023/10155/?time=564)

```swift
struct ContentView: View {

    var body: some View {
        VStack {
            Text("Hello World")
            Button {
                
            } label: {
                Text("Add to cart")
            }
            Button {
                
            } label: {
                Text("Remove from cart")
            }
            Button {
                
            } label: {
                Text("Go to cart")
            }
        }
    }
}

```

<img src="preview.png" width="40%" >
