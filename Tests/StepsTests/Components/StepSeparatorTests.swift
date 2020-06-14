//
//  SeparatorTests.swift
//  StepsTests
//
//  Created by Saul Moreno Abril on 20/04/2020.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Steps

extension Separator: Inspectable { }

final class SeparatorTests: XCTestCase {
    let config = Config()
    let data = ["First", "Second"]
    lazy var state: StepsState = {
        return StepsState(data: data)
    }()

    let delay = 0.5

    func testSeparator() {
        let container = Separator<String>(step: Step())

        let exp = container.inspection.inspect { _ in
            self.state.nextStep() // 1
        }
        let exp2 = container.inspection.inspect(after: delay * 2) { _ in
            self.state.previousStep()  // 0

            self.state.nextStep() // 1
            self.state.nextStep() // 2
        }
        let exp3 = container.inspection.inspect(after: delay * 4) { _ in
            self.state.previousStep() // 1
            self.state.previousStep() // 0
        }
        ViewHosting.host(view: container
            .environmentObject(state)
            .environmentObject(config)
        )
        wait(for: [exp, exp2, exp3], timeout: 5)
    }
}
