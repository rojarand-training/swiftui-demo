## `nonmutating` in action

By denoting a property `set` as `nonmutating` we are able to reassign a value of the property in mutating context:

```swift

struct ContentView: View {
    @State var title = "hello world"
    @PersistentCounter var counter
    var body: some View {
        VStack {
            Button("Change Title") {
                counter = counter + 1//Reassingning!!!
                title = "hello world, times: \(counter)"
            }
            Text("Title: \(title)")
        }
    }
}

@propertyWrapper struct PersistentCounter {
    var wrappedValue: Int {
        nonmutating set {
            UserDefaults().set(newValue, forKey: Self.keyName)
            UserDefaults().synchronize()
        }
        
        get {
            let value = UserDefaults().integer(forKey: Self.keyName)
            return value
        }
    }
    
    init(wrappedValue: Int) {
        self.wrappedValue = wrappedValue
    }
    
    init() {
        let initValue = UserDefaults().integer(forKey: Self.keyName)
        self.init(wrappedValue: initValue)
    }
    
    private static var keyName = "COUNTERX"
}
```

Without it, `counter = couter + 1` breakes the compilation with: `Cannot assign to property: 'self' is immutable` error.

<img src="preview.gif">
