## Pointers

https://www.kodeco.com/7181017-unsafe-swift-using-pointers-and-interacting-with-c?page=1

https://quickbirdstudios.com/blog/swift-unsafe-raw-bytes-pointers-ios/

```swift
@frozen
enum MemoryLayout<T>
```
The memory layout of a type, describing its size, stride, and alignment.

`static var size: Int`

The contiguous memory footprint of T, in bytes.

`static var alignment: Int`

The default memory alignment of T, in bytes.

`static var stride: Int`

The number of bytes from the start of one instance of `T` to the start of the next when stored in contiguous memory or in an `Array<T>`.

Always use a multiple of a type’s **stride** instead of its size when allocating memory or accounting for the distance between instances in memory. 

##Samples in tests