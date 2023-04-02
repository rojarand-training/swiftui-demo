## [Custom predicates](https://www.swiftbysundell.com/articles/predicates-in-swift/)

```swift
extension Predicate {
    static func &&(lhs: Predicate, rhs: Predicate) -> Predicate {
        Predicate { todo in
            lhs.matching(todo) && rhs.matching(todo)
        }
    }
    static func ||(lhs: Predicate, rhs: Predicate) -> Predicate {
        Predicate { todo in
            lhs.matching(todo) || rhs.matching(todo)
        }
    }
}

extension Array where Element == TODO {
    func matching(_ predicate: Predicate<TODO>) -> [TODO] {
        self.filter { todo in
            predicate.matching(todo)
        }
    }
}
```

