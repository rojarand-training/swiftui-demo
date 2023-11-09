## [type(of:)](https://developer.apple.com/documentation/swift/type(of:))

```swift
class Smiley {
    class var text: String {
        return ":)"
    }
}


class EmojiSmiley: Smiley {
     override class var text: String {
        return "😀"
    }
}


func printSmileyInfo(_ value: Smiley) {
    let smileyType = type(of: value)
    print("Smile!", smileyType.text)
}


let emojiSmiley = EmojiSmiley()
printSmileyInfo(emojiSmiley)
// Smile! 😀
```

