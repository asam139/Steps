//
//  StepSeparator.swift
//  curlyhair
//
//  Created by Saul Moreno Abril on 09/04/2020.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import SwiftUI
import SwifterSwiftUI

/// Element to represent each separator between steps
struct StepSeparator: View {
    /// Index of this step
    private(set) var index: Int

    /// The main state
    @ObservedObject private(set) var state: StepsState

    /// The style of the component
    @EnvironmentObject var config: StepsConfig

    /// Helper to inspect
    let inspection = Inspection<Self>()

    /// Previous index
    @State private var previousIndex: Int = 0

    /// Current scale to be animated
    @State private var scaleX: CGFloat = 1

    /// Min scale in the axis X
    private let minScaleX: CGFloat = 0.25

    /// Get current step state  for the set index
    private var stepState: StepState {
        return state.stepStateFor(index: index)
    }

    /// Get foreground color for the current step
    private var foregroundColor: Color {
        switch stepState {
        case .uncompleted,
             .current:
            return config.disabledColor
        default:
            return config.primaryColor
        }
    }

    /// Update the scale to animate according the next index
    private func updateScale(nextIndex: Int) {
        let diff = nextIndex - previousIndex
        if abs(diff) != 1 {
            scaleX = 1
            return
        }

        if (previousIndex == index && diff > 0) {
            scaleX = minScaleX
        } else if (nextIndex == index && diff < 0) {
            scaleX = minScaleX
        } else {
            scaleX = 1
        }
    }

    var body: some View {
        StepContainer {
            Rectangle()
                .frame(height: config.lineThickness)
                .scaleEffect(x: scaleX, y: 1, anchor: .center)
        }
        .foregroundColor(foregroundColor)
        .animation(config.animation)
        .onReceive(state.$currentIndex, perform: { (nextIndex) in
            self.updateScale(nextIndex: nextIndex)
            let previousScaleX = self.scaleX
            DispatchQueue.main.asyncAfter(deadline: .now() + self.config.animationDuration) {
                if (self.scaleX != 1 && previousScaleX == self.scaleX) {
                    self.scaleX = 1
                }
            }
            self.previousIndex = nextIndex
        })
            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

#if DEBUG
struct StepSeparator_Previews: PreviewProvider {
    static var previews: some View {
        let steps = [Step(title: "First"), Step(), Step()]
        let state = StepsState(steps: steps)
        return StepSeparator(index: 0, state: state).environmentObject(StepsConfig())
    }
}
#endif
