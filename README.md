## [Variant model decoding example](https://www.swiftbysundell.com/articles/handling-model-variants-in-swift/)

It is worth to mention that `Decoder` class has two methods to obtain a `container`.
1. `container(keyedBy: Key.Type)`
 The above method allows to decode step by step by passing key describing name of a property to decode.

```swift
extension Item: Decodable {
    enum Properties: CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Properties.self)
        let type = try container.decode(ItemVariantType.self, forKey: .type)
        ...
    }
}
```

Should be used when a *swift* model is differtent than its encoded representation.

2. `singleValueContainer()`
The above method returns container which is able to decode an entire `Decodable` instance.

```swift
let container = try decoder.singleValueContainer()
let item = try container.decode(Item.self)
```

Should be used when a *swift* model is the same as its encoded representation.

<img src="preview.png" width="80%" >
