## [Collect, merge many example](https://www.donnywals.com/using-map-flatmap-and-compactmap-in-combine/)

It is important to remember to properly `mapError` when using `flatMap`. Without it, compilation finishes with obscure compilation errors.

```swift
var countryPublisher: AnyPublisher<Countries, Error> {
        
    guard let url = URL(string: "https://restcountries.com/v2/all") else {
        let error = URLError(.badURL)
        return Fail(outputType: Countries.self, failure: error).eraseToAnyPublisher()
    }
    return URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: CountryNetworkModels.self, decoder: JSONDecoder())
        .map { models in
            models.prefix(10)
        }
        .tryMap { netModels -> [(name: String, url: URL)] in
            try netModels.map { netModel in
                guard let url = URL(string: netModel.flags.png) else {
                    throw URLError(.badURL)
                }
                return (name: netModel.name, url: url)
            }
        }
        .flatMap { (models) -> Publishers.MergeMany<AnyPublisher<Country, Error>> in
            let tasks = models.map { (model) -> AnyPublisher<Country, Error> in
                return URLSession.shared.dataTaskPublisher(for: model.url)
                    .map { (data: Data, response: URLResponse) in
                        Country(name: model.name, pngData: data)
                    }
                    .mapError({ failure in
                        failure as Error
                    })
                    .eraseToAnyPublisher()
            }
            return Publishers.MergeMany(tasks)
        }
        .collect()
        .eraseToAnyPublisher()
}
```

<img src="preview.png" width="80%" >
