//
//  OffsetEffectTests.swift
//  StepsTests
//
//  Created by Saul Moreno Abril on 19/04/2020.
//

import XCTest
import SwiftUI
@testable import Steps

final class OffsetEffectTests: XCTestCase {
    let offset: CGFloat = 0.5
    let pct: CGFloat = 0
    let factor: CGFloat = 0.1

    func testInit() {
        let effect = OffsetEffect(offset: offset, pct: pct, factor: factor)
        XCTAssertEqual(effect.offset, offset)
        XCTAssertEqual(effect.pct, pct)
        XCTAssertEqual(effect.factor, factor)

        let negativeInvalidPct: CGFloat = -0.1
        let nEffect = OffsetEffect(offset: offset, pct: negativeInvalidPct, factor: factor)
        XCTAssertEqual(nEffect.pct, 0.0)

        let positiveInvalidPct: CGFloat = 1.1
        let pEffect = OffsetEffect(offset: offset, pct: positiveInvalidPct, factor: factor)
        XCTAssertEqual(pEffect.pct, 1.0)
    }

    func testAnimatableData() {
        var effect = OffsetEffect(offset: offset, pct: pct, factor: factor)
        XCTAssertEqual(effect.animatableData.first, offset)
        XCTAssertEqual(effect.animatableData.second, pct)

        let newOffset: CGFloat = 0.1
        let newPct: CGFloat = 0.25
        effect.animatableData = AnimatablePair(newOffset, newPct)
        XCTAssertEqual(effect.animatableData.first, newOffset)
        XCTAssertEqual(effect.animatableData.second, newPct)
    }

    func testEffectValue() {
        let initialOffset: CGFloat = 0.0
        var effect = OffsetEffect(offset: initialOffset, pct: pct, factor: factor)

        let newOffset: CGFloat = 0.1
        // Positive offset
        effect.animatableData = AnimatablePair(newOffset, 0.0)
        _ = effect.effectValue(size: CGSize(width: 10, height: 10))
        XCTAssertEqual(effect.offset, newOffset)
        XCTAssertEqual(effect.pct, pct)

        // Negative offset
        effect.animatableData = AnimatablePair(-newOffset, 0.0)
        _ = effect.effectValue(size: CGSize(width: 10, height: 10))
        XCTAssertEqual(effect.offset, -newOffset)
        XCTAssertEqual(effect.pct, pct)

        // Pct
        for value in 0...11 {
            let newPct: CGFloat = CGFloat(value) * 0.1
            effect.animatableData = AnimatablePair(offset, newPct)
            _ = effect.effectValue(size: CGSize(width: 10, height: 10))
            XCTAssertEqual(effect.pct, newPct)
        }
        XCTAssertEqual(effect.offset, offset)
    }

    static var allTests = [
        ("testInit", testInit),
        ("testAnimatableData", testAnimatableData),
        ("testEffectValue", testEffectValue)
    ]
}
