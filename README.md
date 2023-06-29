## [How to show a Map view](https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-a-map-view)

```swift
struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
        Map(coordinateRegion: $region)
            .frame(width: 400, height: 300)
    }
}
```

<img src="preview.gif" width="40%" >
