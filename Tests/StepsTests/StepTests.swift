//
//  StepTests.swift
//  Steps
//
//  Created by Saul Moreno Abril on 19/04/2020.
//

import XCTest
import SwiftUI
@testable import Steps

final class StepTests: XCTestCase {
    func testInitWithTitleAndImage() {
        let title = "Title"
        let image = Image("")

        let step = Step(title: title, image: image)
        XCTAssertEqual(step.title, title)
        XCTAssertEqual(step.image, image)
    }

    static var allTests = [
        ("testInitWithTitleAndImage", testInitWithTitleAndImage)
    ]
}
