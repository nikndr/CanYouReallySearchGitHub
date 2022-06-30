//
//  CanYouReallySearchGitHubUITests.swift
//  CanYouReallySearchGitHubUITests
//
//  Created by Nikandr Marhal on 29.06.2022.
//

import XCTest

class CanYouReallySearchGitHubUITests: XCTestCase {
    func testScrenshots() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        let table = app.tables.element(boundBy: 0)
        XCTAssertTrue(table.exists)

        let cell0 = table.cells.element(boundBy: 0)
        XCTAssertTrue(cell0.exists)

        snapshot("MainScreen")

        cell0.tap()

        // wait for screen to load
        sleep(1)
        let detailsScreen = app.webViews.element(boundBy: 0)
        XCTAssertTrue(detailsScreen.exists)

        // wait for web view to load
        sleep(3)
        snapshot("RepoScreen")
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
