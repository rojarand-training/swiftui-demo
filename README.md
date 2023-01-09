## Example of loading a view controller from xib a file

If name of a xib file is the same as class of a view controller then passing the `nibName` argument can be omitted.

```swift
//XibViewController.xib
XibViewController() //loads view using XibViewController.xib
```

```swift
//XibWithDifferentNameThanClass.xib
XibViewController(nibName: "XibWithDifferentNameThanClass", bundle: nil)
```
