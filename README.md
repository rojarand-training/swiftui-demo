## [Testing combine methods](https://www.swiftbysundell.com/articles/unit-testing-combine-based-swift-code/)

```swift
extension XCTestCase {
    func awaitPublisher<T: Publisher>(publisher: T,
                                      timeout seconds: TimeInterval,
                                      file: StaticString = #file,
                                      line: UInt = #line) throws -> T.Output {
        
        let expectation = self.expectation(description: "Waiting for a result")
        var cancellables = Set<AnyCancellable>()
        var result: Result<T.Output, T.Failure>? = nil
        publisher.sink { completion in
            if case .failure(let error) = completion {
                result = .failure(error)
            }
            expectation.fulfill()
        } receiveValue: { output in
            result = .success(output)
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: seconds)
        
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )
        
        return try unwrappedResult.get()
    }
}

func test_with_helper() throws {
    let result = try awaitPublisher(publisher: Tokenizer().tokenize(sentence: "Foo Bar"), timeout: 0.5)
    XCTAssertEqual(result, ["Foo", "Bar"])
}
```

<img src="preview.gif">
