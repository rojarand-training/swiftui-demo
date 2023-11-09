//
//  SwiftUITipsAndTricksTests.swift
//  SwiftUITipsAndTricksTests
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import XCTest
@testable import SwiftUITipsAndTricks

class Smile {
    
    class var text: String {
        ":)"
    }
}

class EmojiSmile: Smile {
    
    override class var text: String {
        "😊"
    }
}

final class SwiftUITipsAndTricksTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testExample() throws {
        
        func printEmoji(_ emoji: Smile) {
            let type = type(of: emoji)
            print("Smile: \(type.text)")
        }
        
        printEmoji(Smile())
        printEmoji(EmojiSmile())
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
