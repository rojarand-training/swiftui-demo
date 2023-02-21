## Combine Error handling/mapping

```swift
private var countryPublisherWithTryMap: AnyPublisher<Countries, Error> {
    guard let url = URL(string: "https://restcountries.com/v2/all") else {
        return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }
    return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { (data: Data, response: URLResponse) in
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            guard httpResponse.statusCode == 401 else {
                throw BadStatusCodeError()
            }
            return data
        }
        .decode(type: Countries.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}
```

<img src="preview.gif">
