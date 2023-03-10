## Combine example

```swift
private var articlePublisher: AnyPublisher<Articles, Error> {
    $searchToken
        .filter{ token in !token.isEmpty }
        .debounce(for: 0.5, scheduler: DispatchQueue.global())
        .tryMap { token in
            try SearchArticlesURLFormatter.formatURL(containing: String(token))
        }
        .map({ url in
            URLSession.shared.dataTaskPublisher(for: url)
                .mapError { urlError in
                    urlError as Error
                }
        })
        .switchToLatest()
        .tryMap({ output in
            try JSONDecoder().decode(ArticleModels.self, from: output.data).items
        })
        .eraseToAnyPublisher()
}
```

<img src="preview.gif" width="60%" >
