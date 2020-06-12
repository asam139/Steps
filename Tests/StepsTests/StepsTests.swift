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
extension TupleView : Inspectable where T == (Item<String>, Separator<String>?) {}

final class StepsTests: XCTestCase {
    let config = Config()
    let data = ["First", "Second"]
    lazy var state: StepsState = {
        return StepsState(data: data)
    }()

    func testSteps() {
        let container = Steps(state: state, onCreateStep: { string in
            Step(title: string)
        })
        let exp = container.inspection.inspect { view in
            let count = try view.actualView().state.data.count
            for i in 0...count+1 {
                if (i < count) {
                    XCTAssertNoThrow(try view.hStack().forEach(0).view(TupleView<(Item<String>, Separator<String>?)>.self, i))
                } else {
                    XCTAssertThrowsError(try view.hStack().forEach(0).view(TupleView<(Item<String>, Separator<String>?)>.self, i))
                }
            }
        }
        ViewHosting.host(view: container.environmentObject(config))
        wait(for: [exp], timeout: 0.1)
    }
}
