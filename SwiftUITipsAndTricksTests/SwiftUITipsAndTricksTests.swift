//
//  SwiftUITipsAndTricksTests.swift
//  SwiftUITipsAndTricksTests
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import XCTest
@testable import SwiftUITipsAndTricks

final class SwiftUITipsAndTricksTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_changing_bytes_of_primitive() throws {
        var i32: Int32 = 0x00000000
        let bytes = withUnsafeMutableBytes(of: &i32) { bytes in
            bytes[0] = 0xAA
            return bytes
        }
        bytes[1] = 0xBB
        XCTAssertEqual(0x0000BBAA, i32)
    }
    
    struct SampleStruct {
      let number: UInt32
      let flag: Bool
    }
    
    func test_changing_bytes_of_struct() throws {
        var sampleStruct = SampleStruct(number: 0, flag: false)
        withUnsafeMutableBytes(of: &sampleStruct) { bytes in
            bytes[0] = 0xAA
            bytes[MemoryLayout<SampleStruct>.size-1] = 0x01
        }
        XCTAssertEqual(sampleStruct.number, 0x000000AA)
        XCTAssertEqual(sampleStruct.flag, true)
    }
    
    func test_storing_and_loading_struct_from_raw_bytes() throws {
        let count = 2
        let size = MemoryLayout<SampleStruct>.size              // returns 5
        let alignment = MemoryLayout<SampleStruct>.alignment    // returns 4
        let stride = MemoryLayout<SampleStruct>.stride          // returns 8
        
        let pointer = UnsafeMutableRawPointer.allocate(byteCount: count*stride, alignment: alignment)
        defer {
            pointer.deallocate()
        }
        
        let inSS1 = SampleStruct(number: 0xAACC, flag: false)
        pointer.storeBytes(of: inSS1, as: SampleStruct.self)
        let outSS1 = pointer.load(as: SampleStruct.self)
        XCTAssertEqual(inSS1.number, outSS1.number)
        XCTAssertEqual(inSS1.flag, outSS1.flag)
        
        let inSS2 = SampleStruct(number: 123, flag: true)
        pointer.advanced(by: stride).storeBytes(of: inSS2, as: SampleStruct.self)
        let outSS2 = pointer.advanced(by: stride).load(as: SampleStruct.self)
        XCTAssertEqual(inSS2.number, outSS2.number)
        XCTAssertEqual(inSS2.flag, outSS2.flag)
    }
    
    func test_storing_and_loading_struct_from_typed_pointer() throws {
        
        let pointer = UnsafeMutablePointer<SampleStruct>.allocate(capacity: 2)
        defer {
            pointer.deallocate()
        }
        
        let inSS1 = SampleStruct(number: 0xAACC, flag: false)
        pointer.pointee = inSS1
        let outSS1 = pointer.pointee
        XCTAssertEqual(inSS1.number, outSS1.number)
        XCTAssertEqual(inSS1.flag, outSS1.flag)
        
        let inSS2 = SampleStruct(number: 123, flag: true)
        pointer.pointee = inSS2
        let outSS2 = pointer.pointee
        XCTAssertEqual(inSS2.number, outSS2.number)
        XCTAssertEqual(inSS2.flag, outSS2.flag)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
