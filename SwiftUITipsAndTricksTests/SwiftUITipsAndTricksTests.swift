//
//  SwiftUITipsAndTricksTests.swift
//  SwiftUITipsAndTricksTests
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import XCTest
import Combine
@testable import SwiftUITipsAndTricks

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

final class SwiftUITipsAndTricksTests: XCTestCase {
    
    func test_without_helper() throws {
        
        let expectation = self.expectation(description: "Waiting for a result")
        var cancellables = Set<AnyCancellable>()
        
        var result: [String] = []
        Tokenizer().tokenize(sentence: "Foo Bar")
            .sink { completion in
                if case .finished = completion {
                    expectation.fulfill()
                }
            } receiveValue: { value in
                result = value
            }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(result, ["Foo", "Bar"])
        
    }
    
    func test_with_helper() throws {
        let result = try awaitPublisher(publisher: Tokenizer().tokenize(sentence: "Foo Bar"), timeout: 0.5)
        XCTAssertEqual(result, ["Foo", "Bar"])
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
