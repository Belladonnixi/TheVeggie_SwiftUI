//
//  Project: TheVeggie
//  TheVeggieUITestsLaunchTests.swift
//
//
//  Created by Jessica Ernst on 17.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import XCTest

final class TheVeggieUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
