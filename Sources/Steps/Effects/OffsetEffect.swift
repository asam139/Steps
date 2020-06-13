//
//  OffsetEffect.swift
//  Steps
//
//  Created by Saul Moreno Abril on 11/04/2020.
//

import SwiftUI

// Custom offset effect to simulate acceleration deforming the view
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct OffsetEffect: GeometryEffect {

    /// The initial offset of the effect
    private(set) var initialOffset: CGFloat

    /// The offset of the effect
    private(set) var offset: CGFloat

    /// The percentage between two values of offset. [0, 1]
    private(set) var pct: CGFloat

    /// The factor to control the deformation
    private(set) var factor: CGFloat

    /// The difference the offset in each update
    private var offsetDiff: CGFloat = 0

    /// Block when animation is finished
    private var onCompletion: (() -> Void)?

    /// Initializes a new offset effect
    ///
    /// - Parameters:
    ///   - offset: offset to be animated
    ///   - pct: percentage of the animation
    ///   - factor: factor to deform
    ///   - onCompletion: completion block
    init(offset: CGFloat, pct: CGFloat, factor: CGFloat = 0.1, onCompletion: (() -> Void)? = nil) {
        self.initialOffset = offset
        self.offset = offset
        self.factor = factor
        if (pct >= 0.0 && pct <= 1.0) {
            self.pct = pct
        } else {
            self.pct = pct < 0.0 ? 0.0 : 1.0
        }
        self.onCompletion = onCompletion
    }

    func checkIfFinished() {
        if let onCompletion = onCompletion, initialOffset == offset {
            DispatchQueue.main.async {
                onCompletion()
            }
        }
    }

    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { return AnimatablePair<CGFloat, CGFloat>(offset, pct) }
        set {
            offsetDiff = (offset - newValue.first)

            offset = newValue.first
            pct = newValue.second

            checkIfFinished()
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
