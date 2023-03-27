## [Regular expressions](https://www.hackingwithswift.com/swift/5.7/regexes)

Swift parses your regular expressions at compile time, making sure they are valid .

To see how powerful this difference is, consider this code:

```swift
let search1 = /My name is (.+?) and I'm (\d+) years old./
let greeting1 = "My name is Taylor and I'm 26 years old."

if let result = try? search1.wholeMatch(in: greeting1) {
    print("Name: \(result.1)")
    print("Age: \(result.2)")
}
```

That creates a regex looking for two particular values in some text, and if it finds them both prints them. But notice how the result tuple can reference its matches as `.1` and `.2`, because Swift knows exactly which matches will occur. (In case you were wondering, `.0` will return the whole matched string.)

In fact, we can go even further because regular expressions allow us to name our matches, and these flow through to the resulting tuple of matches:

```swift
let search = /My name is (?<name>.+?) and I'm (?<age>\d+) years old./
let greeting = "My name is Taylor and I'm 26 years old."
if let result = try? search.wholeMatch(in: greeting) {
    print("Name: \(result.name)")
    print("Age: \(result.age)")
}
```

Other examples

```swift
Text("I like bats".replacing(/[a-d]ats/, with: "dogs"))
Text("I like cats".replacing(/[a-d]ats/, with: "dogs"))
Text("I like rats".replacing(/[a-d]ats/, with: "dogs"))
```

<img src="preview.png" width="40%" >
