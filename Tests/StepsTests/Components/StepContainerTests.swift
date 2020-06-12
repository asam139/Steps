//
//  ContainerTests.swift
//  StepsTests
//
//  Created by Saul Moreno Abril on 19/04/2020.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Steps

extension Container: Inspectable { }

final class ContainerTests: XCTestCase {
    let config = Config()

    func testContainer() {
        let title = "Title"

        let container = StepContainer(title: title) {
            Text(title)
        }
        XCTAssertEqual(container.title, title)

        let exp = container.inspection.inspect { view in
            XCTAssertNoThrow(try view.vStack().vStack(0))
            XCTAssertNoThrow(try view.vStack().text(1))
        }
        ViewHosting.host(view: container.environmentObject(config))
        wait(for: [exp], timeout: 0.1)
    }
}
