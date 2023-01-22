## Show loaded content on list using `URLSession.shared.dataTaskPublisher`

```swift
    private func loadCountries() -> AnyPublisher<[Country], Error> {
        guard let url = URL(string: "https://restcountries.com/v2/all") else {
            let error: Error = URLError(.badURL)
            return Fail(outputType: [Country].self, failure: error).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Country].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
```


<img src="preview.gif" width="40%" >
