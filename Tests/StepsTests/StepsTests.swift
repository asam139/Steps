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
extension TupleView: Inspectable where T == (AnyView, AnyView?) {}

final class StepsTests: XCTestCase {
    let config = Config()
    let data = ["First", "Second"]
    lazy var state: StepsState = {
        return StepsState(data: data)
    }()

    func testSteps() {
        let container = Steps(state: state, onCreateStep: { string in
            Step(title: string, image: Image(""))
        })
        let exp = container.inspection.inspect { view in
            let count = try view.actualView().state.data.count
            for i in 0..<count {
                XCTAssertNoThrow(try view.hStack().forEach(0).view(TupleView<(AnyView, AnyView?)>.self, i))
            }
        }
        ViewHosting.host(view: container.environmentObject(config))
        wait(for: [exp], timeout: 0.1)
    }

    func testBuilders() {
        let itemSpacing: CGFloat = 10.0
        let size: CGFloat = 15.0
        let lineThickness: CGFloat = 2.0
        let primaryColor = Color.red
        let secondaryColor = Color.yellow
        let disabledColor = Color.gray
        let defaultImage = Image("")

        var container = Steps(state: state, onCreateStep: { string in Step(title: string)})
            .itemSpacing(itemSpacing)
            .size(size)
            .lineThickness(lineThickness)
            .primaryColor(primaryColor)
            .secondaryColor(secondaryColor)
            .disabledColor(disabledColor)
            .defaultImage(defaultImage)

        #if !os(tvOS)
        container = container.onSelectStepAtIndex({ (_) in })
        XCTAssertNotNil(container.onSelectStepAtIndex)
        #endif

        XCTAssertEqual(container.config.itemSpacing, itemSpacing)
        XCTAssertEqual(container.config.size, size)
        XCTAssertEqual(container.config.lineThickness, lineThickness)
        XCTAssertEqual(container.config.primaryColor, primaryColor)
        XCTAssertEqual(container.config.secondaryColor, secondaryColor)
        XCTAssertEqual(container.config.disabledColor, disabledColor)
        XCTAssertEqual(container.config.defaultImage, defaultImage)
    }
}
