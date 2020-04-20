//
//  StepSeparatorTests.swift
//  StepsTests
//
//  Created by Saul Moreno Abril on 20/04/2020.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Steps

extension StepSeparator: Inspectable { }

final class StepSeparatorTests: XCTestCase {
    let config = StepsConfig()
    let steps = [Step(), Step()]
    lazy var state: StepsState = {
        return StepsState(steps: steps)
    }()

    func testStepSeparator() {
        let container = StepSeparator(index: 1, state: state)
        XCTAssertEqual(container.index, 1)

        let exp = container.inspection.inspect { view in
            self.state.nextStep() // 1
        }
        let exp2 = container.inspection.inspect(after: config.animationDuration * 2) { view in
            self.state.previousStep()  // 0

            self.state.nextStep() // 1
            self.state.nextStep() // 2
        }
        let exp3 = container.inspection.inspect(after: config.animationDuration * 4) { view in
            self.state.previousStep() // 1
            self.state.previousStep() // 0
        }
        ViewHosting.host(view: container.environmentObject(config))
        wait(for: [exp, exp2, exp3], timeout: 5)
    }

    static var allTests = [
        ("testStepSeparator", testStepSeparator)
    ]
}
