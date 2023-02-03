## [Operators](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html)

It is worth to mention that besides default operators there are prefix and postfix operators. Those are single argument static functions.
```swift

var body: some View {
    VStack {
        Text("P(1,1)=+P(1,1): \(somePoint.description)")
        Text("Postfix: P(0,0)++: \((Point(x: 0, y: 0)++).description)")
        Text("Prefix: --P(0,0): \((--Point(x: 0, y: 0)).description)")
        Text("P(1,2) + P(2,0) = \((Point(x:1, y:2)+Point(x: 2, y: 0)).description)")
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        "x:\(x), y:\(y)"
    }
    
    static prefix func -- (point: Point) -> Point {
        Point(x: point.x-1, y: point.y-1)
    }
    
    static func + (point1: Point, point2: Point) -> Point {
        Point(x: point1.x+point2.x, y: point1.y+point2.y)
    }
    
    static postfix func ++ (point: Point) -> Point {
        Point(x: point.x+1, y: point.y+1)
    }
    
    static func += (point1: inout Point, point2: Point) {
        point1 = Point(x: point1.x+point2.x, y: point1.y+point2.y)
    }
}

```

<img src="preview.png" width="40%" >
