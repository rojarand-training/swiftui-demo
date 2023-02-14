## [Sorting collections](https://www.swiftbysundell.com/articles/sorting-swift-collections/)

By conforming a building block to `Comparable`, the `sorted` method becomes available. 

```swift
extension Country: Comparable {
    static func < (lhs: Country, rhs: Country) -> Bool {
        lhs.name < rhs.name
    }
}

extension ContentViewModel {
    func sortByDefault() {
        countries = countries.sorted()
    }
}
```

To use `SortDescriptor` the building block has to expose itself to *@objc* runtime.

```swift

class Country: NSObject {
    let name: String
    @objc let areaInSquareKm: Double
    let citiesOver1M: Int
}
...
countries = countries.sorted(using: SortDescriptor(\Country.areaInSquareKm, order: .forward))
```

<img src="preview.gif" width="60%">
