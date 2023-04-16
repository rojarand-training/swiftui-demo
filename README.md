## [Mark content as private using privacysensitive](https://www.hackingwithswift.com/quick-start/swiftui/how-to-mark-content-as-private-using-privacysensitive)

```swift

struct ContentView: View {
    
    var body: some View {
        PersonalInfoView()
            .environment(\.redactionReasons, .privacy)
    }
}

struct PersonalInfoView: View {
    
    @Environment(\.redactionReasons) var redactionReasons
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text("Sex orientation: ")
                Text("Gay")
                    .privacySensitive()
            }
            HStack {
                Text("Card number: ")
                Text("1234-4567-8901-2345-6789")
                    .privacySensitive()
            }
            HStack {
                Text("ID: ")
                if redactionReasons.contains(.privacy) {
                    Text("[HIDDEN]")
                } else {
                    Text("CDA 98765432")
                }
            }
        }
    }
}


```

<img src="preview.png" width="40%" >
