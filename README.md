## [Store collections of references weakly](https://www.swiftbysundell.com/articles/combining-value-and-reference-types-in-swift/)

Weak refenrence can be applied to reference type only.
```swift
Weak<Object: AnyObject> {
    weak var object: Object?
}
```
Unfortunatelly it leads to the following erorr:

Error: 'Weak' requires that 'MagicNumberObserver' be a class type when applying struct.

Thanks to applying the "provider" closure we are able to fix the error.

> Note!!! For structures `object` it will always be `nil`

```swift
struct Weak<Object> {
    var object: Object? {
        provider()
    }
    
    private let provider: () -> Object?
    
    init(_ object: Object) {
        let reference = object as AnyObject
        provider = { [weak reference] in
            reference as? Object
        }
    }
}

struct NonLeakyMagicNumberGenerator {
    
    private var observers = [Weak<MagicNumberObserver>]()
    
    func generate() {
        let number = drawMagicNumber()
        notifyNumberChanged(number)
    }
    
    mutating func addObserver(_ observer: MagicNumberObserver) {
        observers.append(Weak(observer))
    }
    
    private func notifyNumberChanged(_ number: Int) {
        observers.forEach { weakObserver in
            weakObserver.object?.onMagicNumber(number)
        }
    }
}

```
