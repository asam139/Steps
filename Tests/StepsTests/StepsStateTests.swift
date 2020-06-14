//
//  StepsStateTests.swift
//  StepsTests
//
//  Created by Saul Moreno Abril on 20/04/2020.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Steps

final class StepsStateTests: XCTestCase {
    let data = ["First", "Second"]

    func testStepsTests() {
        let state = StepsState(data: data)

        let currentIndex = state.currentIndex

        state.setStep(100)
        XCTAssertEqual(state.currentIndex, currentIndex)
        state.setStep(currentIndex + 1)
        XCTAssertEqual(state.currentIndex, currentIndex + 1)
        state.setStep(currentIndex)

        state.nextStep()
        XCTAssertEqual(state.currentIndex, currentIndex + 1)
        state.nextStep()
        XCTAssertEqual(state.currentIndex, currentIndex + 2)
        state.nextStep()
        XCTAssertEqual(state.currentIndex, data.endIndex + 1)
        state.nextStep()
        XCTAssertEqual(state.currentIndex, data.endIndex + 1)
        XCTAssertFalse(state.hasNext)

        state.previousStep()
        XCTAssertEqual(state.currentIndex, currentIndex + 2)
        state.previousStep()
        XCTAssertEqual(state.currentIndex, currentIndex + 1)
        state.previousStep()
        XCTAssertEqual(state.currentIndex, currentIndex)
        state.previousStep()
        XCTAssertEqual(state.currentIndex, currentIndex)
        XCTAssertFalse(state.hasPrevious)
    }

    static var allTests = [
        ("testStepsTests", testStepsTests)
    ]
}
