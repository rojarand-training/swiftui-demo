## Chaining publishers
- [swiftbysundell](https://www.swiftbysundell.com/articles/connecting-and-merging-combine-publishers-in-swift/)
- [swiftwithmajid](https://swiftwithmajid.com/2021/05/04/chaining-publishers-with-combine-framework-in-swift/)
- [peterfriese](https://peterfriese.dev/posts/swiftui-combine-networking-errorhandling/)

```swift
func load() {
    countries = []
    cancellable = countriesLocalStoragePublisher()
        //replace error with empty array of countries
        .replaceError(with: [Country]())
        .flatMap { countries in
            //If county list is empty try to load from remote storage
            if countries.isEmpty {
                return self.countriesRemoteStoragePublisher()
            } else {
                return Just(countries)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
        }
        .receive(on: RunLoop.main)
        .sink { error in
            
        } receiveValue: { countries in
            self.countries = countries
        }
}
```

<img src="preview.gif">
