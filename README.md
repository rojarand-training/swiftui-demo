## [Multiline string tips and tricks](https://www.swiftbysundell.com/tips/multiline-string-literal-tips-and-tricks/)

Multiline string allows:
- Applying quotation marks without escaping
- Breaking lines
- Interpolation

> Indentations are relative to their closing set of quotation marks

```swift
let name = "Robert"
let multilineString = """
    Hello \(name)
            - "\(name)" is a cool name
        I hope you are ok today.
        - Good bye \(name)
    """
```

<img src="preview.png" width="40%" >
