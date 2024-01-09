//
//  SwiftUITipsAndTricksUITests.swift
//  SwiftUITipsAndTricksUITests
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import XCTest

final class SwiftUITipsAndTricksUITests: XCTestCase {

    func test_main_view_has_expected_title() {
        let app = XCUIApplication()
        app.launch()
        
        let addTaskButton = app.buttons["addTaskButton"]
        addTaskButton.tap()
        
        let addTaskNavBarTitle = app.staticTexts["Add Task"]
        XCTAssert(addTaskNavBarTitle.waitForExistence(timeout: 0.5))
    }
}

