## (Array with mixed types)[https://www.swiftbysundell.com/questions/array-with-mixed-types/]

1. Using `Any`

```swift
let anyMedia: [Any] = [AnyVideo(duration: 1), AnyPhoto(sizeInBytes: 1)]
```

2. Using `AnyItem`

```swift
protocol AnyItem {
    var id: String { get }
    var title: String { get }
}

typealias Item = AnyItem & Identifiable

struct Video {
    let id: String
    let title: String
    let duration: TimeInterval
}

struct Photo {
    let id: String
    let title: String
    let sizeInBytes: UInt
}

```

With this approach we can return common base:
```swift
let items: [AnyItem] = [Video(id: "1", title: "1", duration: 1), Photo(id: "1", title: "1", sizeInBytes: 1)]

func filterItems(withTitle title: String) -> [AnyItem] {
    items.filter{ item in item.title == title  }
}
```

3. As an enum
```
enum EItem {
    case video(Video)
    case photo(Photo)
}

let eitems: [EItem] = [.video(Video(id: "1", title: "1", duration: 1)), .photo(Photo(id: "1", title: "1", sizeInBytes: 1))]
```
