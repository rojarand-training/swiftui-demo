## [ZStack, image, badge](https://www.swiftbysundell.com/articles/swiftui-layout-system-guide-part-1/)

[Alignment](https://www.swiftbysundell.com/articles/swiftui-layout-system-guide-part-3/)

```swift
extension View {
    
    func alignAsBadge(withRatio ratio: CGFloat = 0.8,
                      alignment: Alignment = .topTrailing) -> some View {
        alignmentGuide(alignment.horizontal) { viewDimensions in
            viewDimensions.width * ratio
        }
        .alignmentGuide(alignment.vertical) { viewDimensions in
            //viewDimensions.height * (1.0 - ratio)
            viewDimensions[.bottom] - viewDimensions.height * ratio
        }
    }
}
```

<img src="preview.png" width="40%" >
