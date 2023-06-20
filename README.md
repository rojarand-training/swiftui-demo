## [How to create adaptive layout using viewthatfits](https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-an-adaptive-layout-with-viewthatfits)

SwiftUI gives us ViewThatFits so that **we can have it select from one of several possible layouts based on what fits into the available screen space**. This makes it a fantastic way to make sure your app looks great from the largest tvOS screen down to the smallest Apple Watch.

In its simplest form, you should list all the layout alternatives you want from most preferred to least preferred, and SwiftUI will try them all until it finds one that fits into the space

```swift
var body: some View {
    ViewThatFits {
        //This one is too long. It does not fit.
        Label("Welcome to AwsomeApp hahaahaha", systemImage: "bolt.shield")
            .font(.largeTitle)
        
        //This one is first which fits and is presented.
        Label("Hello again", systemImage: "bolt.shield")
            .font(.largeTitle)
        
        Label("Hello", systemImage: "bolt.shield")
    }
}
```

<img src="preview.png" width="40%" >
