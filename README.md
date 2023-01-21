## Hashable example

To make an object *hashable* you need to implement `Hashable` protocol for the object.

```swift
struct P: Hashable {
    let x: Float
    let y: Float
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
```

The hash value is kept in `hashValue` property.
```swift
P(x: 2.0, y: 3.0).hashValue
```

> Note!!! Hash values are recomputed every time an app is launch.
<img src="preview.gif">
