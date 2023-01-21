## [Hashable](https://developer.apple.com/documentation/swift/hashable)

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

Declaration of the `Hashable` protocol is following:
```swift
public protocol Hashable : Equatable {
    ...
}
```
The Hashable protocol inherits from the Equatable protocol, so you must also satisfy that protocol’s requirements.

The compiler **automatically synthesizes** your custom type’s Hashable and requirements when you declare Hashable conformance in the type’s original declaration and your **type meets** these criteria:

- For a `struct`, all its stored properties must conform to Hashable or Equatable.

- For an `enum`, all its associated values must conform to Hashable. (An enum without associated values has Hashable conformance even without the declaration.)

```swift
struct User {
    let name: String
    let age: Int
}

extension User: Hashable {   
    func hash(into hasher: inout Hasher) {
        hasher.combine(age)
    }
}
```
> Note!!! There is no need to explicitly conform to the `Equatable`. It is **automatically synthesized**.

In the following example we need to conform to the `Equatable`, because the `Email` stored property does not conform to `Hashable` or `Equatable`.

```swift
struct Email {
    let value: String
}
struct GmailUser {
    let name: String //Note the Email does not conform to Hashable or Equatable
    let email: Email
}

//Compilation error: Type 'GmailUser' does not conform to protocol 'Equatable'
extension GmailUser: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
```

To fix the error we need to implicitly make `GmailUser` conform to the `Equatable` protocol:
```swift
extension GmailUser: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        (lhs.email.value == rhs.email.value) && (lhs.name == rhs.name)
    }
}
```

, or make Email conforming to the `Hashable`:

```swift
extension Email: Hashable {   
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}
```

or `Equatable`:
```swift
extension Email: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.value == rhs.value
    }
}
```

> Note!!! Hash values are recomputed every time an app is launch.
<img src="preview.gif">
