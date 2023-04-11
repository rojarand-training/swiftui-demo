//
//  SwiftUITipsAndTricksTests.swift
//  SwiftUITipsAndTricksTests
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import XCTest
@testable import SwiftUITipsAndTricks

struct Product {
    let price: Double
    let name: String
    let isPromotion: Bool
    let madeInChina: Bool
}

extension Product: Equatable {
}

func ~=<T>(keyPath: KeyPath<T, Bool>, rhs: T?) -> Bool {
    rhs?[keyPath:keyPath] ?? false
}

final class SwiftUITipsAndTricksTests: XCTestCase {

    func testExample() throws {
        
        let text = "Some text"
        switch text.first {
        case \.isNumber:
            print("Number")
            break
        case \.isLetter:
            print("Letter")
            break
        default:
            print("No number, no letter")
            break

        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
