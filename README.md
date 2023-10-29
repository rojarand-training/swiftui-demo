## [Consuming](https://www.hackingwithswift.com/articles/258/whats-new-in-swift-5-9)

## [Ownership](https://developer.apple.com/videos/play/wwdc2023/10164/?time=1405)

`~Copyable` structures can make usage of instances unavailable when an instance is not longer usable. Take the following `FileDescriptor` implementation as an example.

```swift
struct FileDescriptor: ~Copyable {
    
    private var fd: Int
    
    init(_ fd: Int) {
        self.fd = fd
    }
    
    func write(bytes: [Int8]) {
        FileWrite(fd, bytes)
    }
    
    consuming func close() {
        FileClose(fd)
        self.fd = 0
    }
}
```

Writing after closing a file is a bug. Hence we can prevent it in compile time making the `write` method `consuming`.

```swift
func test_use_write_after_consuming_close() throws {
    let fileDescriptor = FileDescriptor(Int.random(in: 1...Int.max))
    fileDescriptor.close()
    //fileDescriptor.write(bytes: [1,2,3]) <<< --- compile error
}
```

<img src="preview.png" width="100%" >

Wrapping structure must be also `~Copyable`

```swift
struct FileDescriptorWrapper: ~Copyable {
    private let fd: FileDescriptor
    init(_ fd: Int) {
        self.fd = FileDescriptor(fd)
    }
    
    func write(bytes: [Int8]) {
        fd.write(bytes: bytes)
    }
    
    /*
    func close() { //'self' is borrowed and cannot be consumed
        fd.close()
    }
    */
}
```
