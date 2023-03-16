## Text example

https://www.avanderlee.com/swift/some-opaque-types/

https://swiftsenpai.com/swift/dynamic-dispatch-with-generic-protocols/

https://swiftsenpai.com/swift/understanding-some-and-any/#:~:text=the%20%E2%80%9Cany%E2%80%9D%20Keyword-,The%20any%20keyword%20was%20introduced%20in%20Swift%205.6.,you%20failed%20to%20do%20so.

Opaque types allow you to describe the expected return type without defining a concrete type. 

```swift
var body: some View { ... }
```

The compiler can see the following return types:
```swift
var body: VStack { ... }

// or:

var body: Text { ... }
```

```swift
struct ContentView: View {
   
    let anyViews: [any View] = [Button("Tap me") {}, Text("Hello") ]
    //Different types can be mixed in 'any' collection
    
    /* Compilation error: "Type of expression is ambiguous without more context"
    let someViews: [some View] = [Button("Tap me") {}, Text("Hello") ]
    Different types can not be mixed in 'some' collection
    */
    let someViews: [some View] = [Text("Hello"), Text("World")]

    var body: some View {
        VStack {
            AnyView(anyViews[0])
            someViews[0]
        }
    }
}
```
