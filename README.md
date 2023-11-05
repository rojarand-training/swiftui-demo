## Window example

https://medium.com/@Ariobarxan/what-is-a-window-in-an-ios-application-72698e733f87
https://stackoverflow.com/questions/19995526/to-create-a-new-uiwindow-over-the-main-window

Using window you can overlay window which presents alerts. 
> Since iOS 15 you should create windows using a scene instance.

```swift
if let currentWindowScene = UIApplication.shared.connectedScenes.first as?  UIWindowScene {
    let newWindow = UIWindow(windowScene: currentWindowScene)
    newWindow.backgroundColor = .blue
    newWindow.rootViewController = SomeRootVC()
    newWindow.makeKeyAndVisible()
}
```

Creating windows in using frame argument does not work anymore.

<img src="preview.gif" width="40%" >
