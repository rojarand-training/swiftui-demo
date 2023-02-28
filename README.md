## [switchToLatest](https://www.polpiella.dev/the-power-of-the-switchtolatest-operator)

- [Other resource](https://www.createwithswift.com/reference-combine-switchtolatest/)

A common use case would be that multiple requests for asynchronous work may be issued, but only the **latest request is really needed**. In case if the upstream logic is expensive, then your app performance will be badly affected without cancelling unwanted subscriptions.

For example, requests could be aimed at loading images from a remote source. A user might tap on a button to load the image but may decide to move on and tap on another button to load another image before the first request is even completed. In this case, subscriptions in Combine can be configured with a `.switchToLatest()` operator to receive a new publisher from the upstream publisher and **cancel its previous subscription**.

```swift
init() {
    cancellables = subject
        .map { divider in
            (1...100).filter { value in
                (value % divider) == 0
            }.publisher
                .collect()
                .delay(for: 1, scheduler: DispatchQueue.main) //simulate delay
        }
        .switchToLatest()
        .map({ res in
            "\(res)"
        })
        .assign(to: \.result, on: self)
}
```

<img src="preview.gif">
