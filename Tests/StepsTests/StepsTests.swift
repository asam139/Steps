//
//  StepsTests.swift
//  StepsTests
//
//  Created by Saul Moreno Abril on 20/04/2020.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Steps

extension Steps: Inspectable { }
extension TupleView : Inspectable where T == (Element, Separator?) {}

final class StepsTests: XCTestCase {
    let config = Config()
    let steps = [Step(), Step()]
    lazy var state: StepsState = {
        return StepsState(steps: steps)
    }()

    func testSteps() {
        let container = Steps(state: state, config: config)
        let exp = container.inspection.inspect { view in
            let count = try view.actualView().state.steps.count
            for i in 0...count+1 {
                if (i < count) {
                    XCTAssertNoThrow(try view.hStack().forEach(0).view(TupleView<(Element, Separator?)>.self, i))
                } else {
                    XCTAssertThrowsError(try view.hStack().forEach(0).view(TupleView<(Element, Separator?)>.self, i))
                }
            }
        }
        ViewHosting.host(view: container.environmentObject(config))
        wait(for: [exp], timeout: 0.1)
    }
}
