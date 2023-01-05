## `@ViewBuilder` example

The `@ViewBuilder` attribute is one of the few **result builders** in SwiftUI. You typically use it to create child views for a specific SwiftUI view in a readable way **without having to use any return keywords**. It makes you able to anotate functions too.



```swift
/*
Error: Function declares an opaque return type 'some View', but the return statements in its body do not have matching underlying types
*/
func sampleView(aCondition: Bool) -> some View {
    if aCondition {
        return Text("A condition fullfiled")
    } else {
        return EmptyView()
    }
}

//This version compiles. Note there are no "returns".
@ViewBuilder
func sampleView(aCondition: Bool) -> some View {
    if aCondition {
        Text("A text created by a function")
    } else {
        EmptyView()
    }
}
```

<img src="preview.png" width="40%" >
