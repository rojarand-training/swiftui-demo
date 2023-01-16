## Show weird implicit task scheduler switch.

```swift
class ContentViewModel: ObservableObject {
       
    func fireTask() {
        Task {
            //this is executed in global thread
        }
    }
}

struct ContentView: View {
    ...
    var body: some View {
        Button("Fire view.task") {
            Task {
                //this is executed in main thread
            }
        }
        Button("Fire viewModel.task") {
            viewModel.fireTask()
        }
    }
}
```

<img src="preview.png" width="40%" >
