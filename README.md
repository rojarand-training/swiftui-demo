## #available vs @available

https://www.avanderlee.com/swift/available-deprecated-renamed/

https://www.swiftyplace.com/blog/swift-available

#unavailable https://www.hackingwithswift.com/swift/5.6/unavailable

- `@available` is used to mark the availability for a class or method
```swift
@available(iOS 15, *)
func launchNewAppIntroduction() {
    let appIntroduction = NewAppIntroduction()
}

@available(iOS 15, macOS 12.0, *)
func launchNewAppIntroduction() {
    let appIntroduction = NewAppIntroduction()
}
```

The wildcard means the some code is being available on iOS versions since the specified version or later, or all other platforms – macOS, tvOS, watchOS, and any future unknown platforms.

- `#available` is used to only execute a piece of code for specific platforms and/or versions

```swift
if #available(iOS 14, *) {
    let appIntroduction = NewAppIntroduction()
} else {
    // .. use the old app introduction
}
```

Using `@available` you can also mark a method/class as deprecated or obsolete. 

```swift
@available(iOS, deprecated: 12, obsoleted: 13, message: "We no longer show an app introduction on iOS 14 and up")
func launchAppIntroduction() {
    // ..
}
```

Or renamed.
```swift
@available(*, unavailable, renamed: "launchOnboarding")
func launchAppIntroduction() {
    // Old implementation
}
```

## #unavailable

```swift
if #available(iOS 15, *) { } else {
    // Code to make iOS 14 and earlier work correctly
}
```

We can now write this:

```swift
if #unavailable(iOS 15) {
    // Code to make iOS 14 and earlier work correctly
}
```
