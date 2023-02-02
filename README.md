## Fallthrough jump to the next case in switch

```swift
enum Days {
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun
    
    var name: String {
        switch self {
        case .mon:
            return "Monday"
        ...
        }
    }
    
    var fullDescription: String {
        var description = ""
        switch self {
        case .mon, .tue, .wed, .thu, .fri:
            description = "Working day: "
            fallthrough
        default:
            description += self.name
        }
        return description
    }
}
```

<img src="preview.png" width="40%" >
