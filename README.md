## [Swift futures](https://www.swiftbysundell.com/articles/using-combine-futures-and-subjects/)

Takeaways:
- **Futures are publishers.**
- Futures are greate for adapting closure based code to reactive with Combine.

```swift
func load() {
    cancellable = loadArticle()//Note it returns Future and is used as an publisher
        .replaceError(with: Article(text: "Could not load"))
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: { article in
            self.loadState = .loaded(article)
        })
}

private func loadArticle() -> Future<Article, Error> {
    Future { promise in
        self.loadArticleGCD { article in
            if let article = article {
                promise(.success(article))
            } else {
                promise(.failure(Error.notAvailable))
            }
        }
    }
}

private func loadArticleGCD(handler: @escaping (Article?) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now()+2) {
        if Int.random(in: 1...5)%2 == 0 {
            handler(Article(text: "Hello world"))
        } else {
            handler(nil)
        }
    }
}
```

<img src="preview.gif" width="60%" >
