## [Decoding dates provided in custom format](https://stackoverflow.com/questions/44682626/swifts-jsondecoder-with-multiple-date-formats-in-a-json-string)

There are a few ways to decode a date provided in a custom format

1. Using decoding strategy: `.formatted(formatter)`
```swift
let decoder = JSONDecoder()
let formatter = DateFormatter()
formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
decoder.dateDecodingStrategy = .formatted(formatter) //!!!!!!!!!!
let myStruct = try! decoder.decode(MyStruct.self, from: json)
```

2. Using decoding strategy: `.custom()`
```swift
let decoder = JSONDecoder()
let formatter = DateFormatter()
formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
decoder.dateDecodingStrategy = .custom({ dcdr in
    let strDate = try! dcdr.singleValueContainer().decode(String.self)
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
    return formatter.date(from: strDate)!
})
let myStruct = try! decoder.decode(MyStruct.self, from: json)
```
