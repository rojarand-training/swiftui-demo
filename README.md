## [Custom initializers for simplyfying](https://www.swiftbysundell.com/tips/swiftui-extensions-using-generics/)

We can simplify creating complex views using custom initializers.

```swift
extension Button where Label==Image {
    init(imageSystemName: String, action: @escaping () -> Void) {
        self.init(action: action, label: {
            Image(systemName: imageSystemName)
        })
    }
}

struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("Hello World")
            
            //Normal way
            Button {
                print("Hello")
            } label: {
                Image(systemName: "folder.fill.badge.plus")
            }
            
            //Improved way
            Button(imageSystemName:"folder.fill.badge.plus") {
                print("Hello")
            }
        }
    }
}
```

<img src="preview.png" width="40%" >
