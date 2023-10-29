//
//  SwiftUITipsAndTricksTests.swift
//  SwiftUITipsAndTricksTests
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import XCTest
@testable import SwiftUITipsAndTricks

struct FileDescriptorWrapper: ~Copyable {
    private let fd: FileDescriptor
    init(_ fd: Int) {
        self.fd = FileDescriptor(fd)
    }
    
    func write(bytes: [Int8]) {
        fd.write(bytes: bytes)
    }
    
    /*
    consuming func close() {
        fd.close()
        //discard self
    }*/
    /*
    deinit {
        fd.close()
    }
   	*/
}


final class SwiftUITipsAndTricksTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_use_write_after_consuming_close() throws {
        let fileDescriptor = FileDescriptor(Int.random(in: 1...Int.max))
        fileDescriptor.close()
        //fileDescriptor.write(bytes: [1,2,3])
    }
    
    func test_use_write_after_consuming_close2() throws {
        let fileDescriptor = FileDescriptorWrapper(Int.random(in: 1...Int.max))
        fileDescriptor.write(bytes: [1,2,3])
        ///fileDescriptor.close()
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
