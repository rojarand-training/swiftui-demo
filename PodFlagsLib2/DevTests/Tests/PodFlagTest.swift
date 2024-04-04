//
//  PodFlagTest.swift
//  PodFlagsLib2
//
//  Created by Robert Andrzejczyk on 29/03/2024.
//

import XCTest
@testable import PodFlagsLib2

final class PodFlagTest: XCTestCase {

    func test_example() throws {
        XCTAssertNotNil(PodFlags.getResourcesData(byCountryTag: "us"))
    }
    
    func test_example2() throws {
        XCTAssertNotNil(PodFlags.getBundleData(byCountryTag: "br"))
    }
}
