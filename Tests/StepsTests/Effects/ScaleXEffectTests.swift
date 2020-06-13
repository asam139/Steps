//
//  ScaleXEffectTests.swift
//  Steps
//
//  Created by Saul Moreno Abril on 13/06/2020.
//

import XCTest
import SwiftUI
@testable import Steps

final class ScaleXEffectTests: XCTestCase {
    let scale: CGFloat = 0.5

    func testInit() {
        let effect = ScaleXEffect(scaleX: scale)
        XCTAssertEqual(effect.scaleX, scale)
    }
}
