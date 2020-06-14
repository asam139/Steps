//
//  ScaleXEffect.swift
//  Steps
//
//  Created by Saul Moreno Abril on 13/06/2020.
//

import SwiftUI

// Custom scale x effect to add completion block
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ScaleXEffect: AnimatableModifier {

    /// The initial scale in X-axis of the effect
    var initialScaleX: CGFloat

    /// The  scale in X-axis of the effect
    var scaleX: CGFloat

    /// Block when animation is finished
    var onCompletion: (() -> Void)?

    /// Initializes a new scale effect
    ///
    /// - Parameters:
    ///   - scaleX: scale in the X-axis to be animated
    ///   - onCompletion: completion block
    init(scaleX: CGFloat, onCompletion: (() -> Void)? = nil) {
        self.initialScaleX = scaleX
        self.scaleX = scaleX
        self.onCompletion = onCompletion
    }

    func checkIfFinished() {
        if let onCompletion = onCompletion, scaleX == initialScaleX {
            DispatchQueue.main.async {
                onCompletion()
            }
        }
    }

    var animatableData: CGFloat {
        get { scaleX }
        set {
            scaleX = newValue
            checkIfFinished()
        }
    }

    func body(content: Content) -> some View {
        content.scaleEffect(x: scaleX, y: 1, anchor: .center)
    }
}
