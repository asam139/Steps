//
//  ElementTests.swift
//  StepsTests
//
//  Created by Saul Moreno Abril on 20/04/2020.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Steps

extension Element: Inspectable { }

final class ElementTests: XCTestCase {
    let config = Config()
    let steps = [Step(), Step()]
    lazy var state: StepsState = {
        return StepsState(steps: steps)
    }()

    func testElement() {
        let container = Element(index: 1, state: state)
        XCTAssertEqual(container.index, 1)

        let exp = container.inspection.inspect { _ in
            self.state.nextStep() // 1
        }
        let exp2 = container.inspection.inspect(after: config.animationDuration * 2) { _ in
            self.state.previousStep()  // 0

            self.state.nextStep() // 1
            self.state.nextStep() // 2
        }
        let exp3 = container.inspection.inspect(after: config.animationDuration * 4) { _ in
            self.state.previousStep() // 1
            self.state.previousStep() // 0
        }

        let exp4 = container.inspection.inspect(after: config.animationDuration * 6) { _ in
            self.state.nextStep() // 1
            self.state.nextStep() // 2
            self.state.nextStep() // 3
        }
        ViewHosting.host(view: container.environmentObject(config))
        wait(for: [exp, exp2, exp3, exp4], timeout: 5)
    }

    static var allTests = [
        ("testElement", testElement)
    ]
}
