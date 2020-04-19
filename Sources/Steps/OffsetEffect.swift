//
//  OffsetEffect.swift
//  Steps
//
//  Created by Saul Moreno Abril on 11/04/2020.
//

import SwiftUI

struct OffsetEffect: GeometryEffect {
    private(set) var offset: CGFloat
    private(set) var pct: CGFloat
    private(set) var factor: CGFloat

    private var offsetDiff: CGFloat = 0

    init(offset: CGFloat, pct: CGFloat, factor: CGFloat = 0.1) {
        self.offset = offset
        self.factor = factor
        if (pct >= 0.0 && pct <= 1.0) {
            self.pct = pct
        } else {
            self.pct = pct < 0.0 ? 0.0 : 1.0
        }
    }

    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { return AnimatablePair<CGFloat, CGFloat>(offset, pct) }
        set {
            offsetDiff = (offset - newValue.first)

            offset = newValue.first
            pct = newValue.second
        }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        var skew: CGFloat
        let direction: CGFloat = offsetDiff > 0 ? -1 : 1
        if pct < 0.2 {
            skew = (pct * 5)
        } else if pct > 0.8 {
            skew = ((1 - pct) * 5)
        } else {
            skew = 1
        }
        skew *= direction * factor

        return ProjectionTransform(CGAffineTransform(a: 1, b: 0, c: skew, d: 1, tx: offset, ty: 0))
    }
}
