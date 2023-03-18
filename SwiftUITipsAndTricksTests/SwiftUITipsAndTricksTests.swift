//
//  SwiftUITipsAndTricksTests.swift
//  SwiftUITipsAndTricksTests
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import XCTest
@testable import SwiftUITipsAndTricks

final class SwiftUITipsAndTricksTests: XCTestCase {

    
    func test_misc() {
        Parser.misc()
    }
    
    func test_parse_bites() {
       
        let valBit0 = UnsafeMutablePointer<UInt8>.allocate(capacity: 1)
        let valAtBitFrom2To5 = UnsafeMutablePointer<UInt8>.allocate(capacity: 1)
        let valAtBitFrom6To7 = UnsafeMutablePointer<UInt8>.allocate(capacity: 1)
        Parser.parseByte(0b10110101, valAtBit0: valBit0,
                         valAtBitFrom2To5: valAtBitFrom2To5,
                         valAtBitFrom6to7: valAtBitFrom6To7)
        XCTAssertEqual(valBit0.pointee, 1)
        XCTAssertEqual(valAtBitFrom2To5.pointee, 0b00001101)
        XCTAssertEqual(valAtBitFrom6To7.pointee, 0b00000010)
    }
    
    func test_parse_positive_temperature() {
        
        let bytes: [UInt8] = [0x9E, 0x01, 0x02, 0x3F, 0x00, 0x55, 0x01, 0x3A, 0xFF, 0x00,
                              0xE8, 0x02, 0x5B, 0x00, 0x1C, 0x4F, 0x49, 0x00, 0xE0, 0x52,
                              0x25, 0x02, 0x00, 0x00, 0x00, 0x26, 0x00, 0x3C, 0x17]
        
        let data = Data(bytes)
        let parser = Parser()
        let parsingResult = parser.parse(data)
        XCTAssertEqual(parsingResult.code, .Success)
        
        let advertisementFrame = parsingResult.frames[0] as! SensorAdvertisementFrame
        let message = advertisementFrame.message
        XCTAssertTrue(message.temperature > 0)
    }
    
    func test_parse_multiple_frames() {
        
        var bytes: [UInt8] = [0x9E, 0x01, 0x02, 0x3F, 0x00, 0x55, 0x01, 0x3A, 0xFF, 0x00,
                              0xE8, 0x02, 0x5B, 0x00, 0x1C, 0x4F, 0x49, 0x00, 0xE0, 0x52,
                              0x25, 0x02, 0x00, 0x00, 0x00, 0x26, 0x00, 0x3C, 0x17]
       
        bytes += bytes
        let data = Data(bytes)
        let parser = Parser()
        let parsingResult = parser.parse(data)
        XCTAssertEqual(parsingResult.code, .Success)
        XCTAssertEqual(parsingResult.frames.count, 2)
    }
    
    func test_parse_negative_temperature() {
        
        let bytes: [UInt8] = [0x9E, 0x01, 0x00, 0xAB, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
                              0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF,
                              0xFF, 0xFF, 0xFF, 0x00, 0x14, 0x18, 0x0, 0x21, 0x17]
        
        let data = Data(bytes)
        let parser = Parser()
        let parsingResult = parser.parse(data)
        XCTAssertEqual(parsingResult.code, .Success)
        
        let advertisementFrame = parsingResult.frames[0] as! SensorAdvertisementFrame
        let message = advertisementFrame.message
        XCTAssertTrue(message.temperature < 0)
    }
    
}
