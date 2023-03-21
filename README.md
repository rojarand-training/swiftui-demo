## [Animations and transitions](https://stackoverflow.com/questions/20923481/what-are-the-differences-between-these-three-concepts-animation-transition-and)

- **Animation** is a general term for making a view object change it's appearance smoothly from one state to another state over time.

- **A transition** is a specific type of animation for switching between views, view controllers, or layers. The Core Animation framework includes specific calls to support transitions, as well as more general-purpose animations. 

- [SwiftBySundel - PropertyAnimator](https://www.swiftbysundell.com/basics/animations/)
- [SwiftBySundel](https://www.swiftbysundell.com/articles/building-a-declarative-animation-framework-in-swift-part-2/)

```swift
//Animation
UIView.animate(withDuration: 0.5) {
    label.frame.origin.x += 50 //move right by 50
} completion: { result in
    NSLog("Animation done")
}

//Transition
UIView.transition(with: view, duration: duration, options: .transitionCrossDissolve) {
    label.textColor = .rad
} completion: { result in
    NSLog("Transition done")
}
```
<img src="preview.gif" width="60%" >


