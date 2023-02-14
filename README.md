## Combining publishers

*Published* proprties have `Publisher` capabilities. They can publish values. For instance `@Published var userName: String = ""` property bound to a *TextField* publishes a new string value every time an user type something.

```
struct ContentView: View {
    ...
    TextField("Username", text: $vm.userName)
    ...
}
...

final class ContentViewModel: ObservableObject {
    
    @Published var userName: String = ""

    var userNamePublisher: AnyPublisher<Bool, Never> {
        $userName
            //A publisher that publishes events only after a specified time elapses.
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                print("userName \($0)")
                return $0.count > 5
            }
            .eraseToAnyPublisher()
    }
}
```

Publishers can be **combined** to produce merged result:
```swift
extension ContentViewModel {
    
    var isValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(userNamePublisher, passwordPublisher)
            .map { userNameValid, passwordValid in
                userNameValid && passwordValid
            }.eraseToAnyPublisher()
    }
    
    var userNamePublisher: AnyPublisher<Bool, Never> {
        $userName
            //A publisher that publishes events only after a specified time elapses.
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                print("userName \($0)")
                return $0.count > 5
            }
            .eraseToAnyPublisher()
    }
    
    var passwordPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                print("password \($0)")
                return $0.count > 5
            }
            .eraseToAnyPublisher()
    }
}
```

<img src="preview.gif" width="60%" >
