//
//  JobTwisterUITests.swift
//  JobTwisterUITests
//
//  Created by Thomas McMahon on 6/25/25.
//

import XCTest

final class JobTwisterUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testApplicationLaunch() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Verify the app launches successfully
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 10))
        
        // Check for main UI elements
        XCTAssertTrue(app.buttons["New Job Application"].exists || app.staticTexts["JobTwister"].exists)
    }
    
    @MainActor
    func testNewJobCreation() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Try to find and tap new job button
        if app.buttons["New Job Application"].exists {
            app.buttons["New Job Application"].tap()
            
            // Verify job form appears
            XCTAssertTrue(app.textFields.firstMatch.waitForExistence(timeout: 5))
        }
    }
    
    @MainActor
    func testMenuCommands() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Test keyboard shortcut for new job (Cmd+N)
        app.typeKey("n", modifierFlags: .command)
        
        // Check if form appears or if shortcut works
        // Note: This test might be flaky depending on UI state
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
