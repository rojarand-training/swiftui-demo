## [Variant model decoding example](https://www.swiftbysundell.com/articles/handling-model-variants-in-swift/)

```swift
 init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let decodableItems = try container.decode(DecodableMultimediaItems.self)
    
    videos = decodableItems.items
        .filter { $0.type == .video }
        .map { item in
            Video(name: item.name, type: item.type, length: item.length!)
    }
    
    images = decodableItems.items
        .filter { $0.type == .image }
        .map { item in
            Image(name: item.name, type: item.type, size: item.size!)
    }
}
```

<img src="preview.png" width="80%" >
