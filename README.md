## Content padding

To create padding/insets depending on iOS version use `contentInsets` or `contentEdgeInsets`.

```swift
func createButton() -> UIButton {
    if #available(iOS 15.0, *) {
        var buttonConfiguration = UIButton.Configuration.bordered()
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 30, bottom: 50, trailing: 30)
        return UIButton(configuration: buttonConfiguration, primaryAction: action)
    } else {
        let oldStyleButton = UIButton(frame:.zero, primaryAction: action)
        oldStyleButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 30, bottom: 50, right: 30)
        return oldStyleButton
    }
}
```

<img src="preview.png" width="40%" >
