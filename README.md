## [Combine Throttle vs Debounce](https://blog.canopas.com/swift-11-useful-combine-operators-you-need-to-know-499cfdce0cd5)

The `throttle` operator waits for the specified interval repeatedly, and at the end of each interval, it will emit either the first or the last of the values depending on what is passed for its `latest` parameter.
```swift
.throttle(for: 1, scheduler: DispatchQueue.main, latest: [true|false])
```

The `debounce` operator waits for a specific time span from the emission of the **last** value before emitting the **last** value received. In other words it waits until a publisher before is iddle for the given time, then emits the last value.


<img src="preview.gif">
