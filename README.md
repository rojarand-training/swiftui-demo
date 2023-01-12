## Coordinator example

Two different implementations works exchangebly

1. `UIViewRepresentableContext`
```swift
func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
...
}
```

1. `Context`
```swift
func makeUIView(context: Context) -> UISearchBar {
...
}
```


<img src="preview.gif">
