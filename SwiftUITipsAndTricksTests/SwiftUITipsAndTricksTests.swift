//
//  SwiftUITipsAndTricksTests.swift
//  SwiftUITipsAndTricksTests
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import XCTest
import FlagsLib
import PodFlagsLib2

@testable import SwiftUITipsAndTricks

final class SwiftUITipsAndTricksTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_countries_json_file_is_accessible_via_bundle_main_property() throws {
        let url = Bundle.main.url(forResource: "countries", withExtension: "json")
        XCTAssertNotNil(url)
    }

    func test_countries_test_json_file_is_not_accessible_via_bundle_main_property() throws {
        let url = Bundle.main.url(forResource: "countries-test", withExtension: "json")
        XCTAssertNil(url)
    }
    
    func test_countries_test_json_file_is_accessible_using_test_class() throws {
        let url = Bundle(for: Self.self).url(forResource: "countries-test", withExtension: "json")
        XCTAssertNotNil(url)
    }
    
    func test_countries_test_json_file_is_accessible_via_bundle_allBundles_property() throws {
        let bundle = Bundle.allBundles.first{ $0.bundlePath.contains("SwiftUITipsAndTricksTests") }!
        let url = bundle.url(forResource: "countries-test", withExtension: "json")
        XCTAssertNotNil(url)
    }
    
    func test_flag_data_isaccessible() throws {
        XCTAssertNotNil(FlagsLib.getFlagData(byCountryTag: "pl"))
    }
    
    func test_local_library_resuorces_are_avaliable__path_combined() throws {
        let bundlePath = Bundle.main.bundlePath + "/FlagsLib_FlagsLib.bundle"
        XCTAssertNotNil(Bundle(path: bundlePath)?.url(forResource: "pl", withExtension: "png"))
    }

    func test_framowork_can_access_its_resources() throws {
        XCTAssertNotNil(PodFlags.getResourcesData(byCountryTag: "us"))
    }
    
    func test_framework_resources_are_available_using_its_class_class() throws {
        let url = Bundle(for: PodFlags.self).url(forResource: "us", withExtension: "png", subdirectory: "Flags")
        XCTAssertNotNil(url)
    }
    
    func test_framework_resources_are_available_using_framoworks() throws {
        let url = Bundle.allFrameworks.first{ $0.bundlePath.contains("PodFlagsLib2") }!.url(forResource: "us", withExtension: "png", subdirectory: "Flags")
        XCTAssertNotNil(url)
    }
    
    func test_resource_bundle_resources_are_available_using__parth_combined() throws {
        let bundlePath = Bundle.main.bundlePath + "/Frameworks/PodFlagsLib2.framework/ResourceBundlesPodFlagsLib2.bundle"
        XCTAssertNotNil(Bundle(path: bundlePath)?.url(forResource: "ar", withExtension: "png"))
    }
    
    func test_resource_bundle_resources_are_available_using__framework() throws {
        let url = Bundle.allFrameworks.first{ $0.bundlePath.contains("PodFlagsLib2") }!.url(forResource: "ar", withExtension: "png", subdirectory: "ResourceBundlesPodFlagsLib2.bundle")
        XCTAssertNotNil(url)
    }
    
    func test_resource_bundle_resources_are_available_using_class() throws {
        let url = Bundle(for: PodFlags.self).url(forResource: "ar", withExtension: "png", subdirectory: "ResourceBundlesPodFlagsLib2.bundle")
        XCTAssertNotNil(url)
    }
}
