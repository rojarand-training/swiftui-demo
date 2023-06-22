## [How to create a custom layout using the Layout protocol](https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-custom-layout-using-the-layout-protocol)

```swift
struct RadialLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        
        let angle = Angle(degrees: 360.0/CGFloat(subviews.count)).radians
        let r = min(bounds.width, bounds.height)/2
        subviews.enumerated().forEach { index, subview in
            let angleDelta = CGFloat(index)*angle
            var dx = cos(angleDelta) * r
            let dy = sin(angleDelta) * r
            subview.place(at: CGPoint(x: bounds.midX+dx, y: bounds.midY+dy), anchor: .center, proposal: proposal)
        }
        
    }
}
```

<img src="preview.png" width="40%" >
