//
//  Separator.swift
//  Steps
//
//  Created by Saul Moreno Abril on 09/04/2020.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import SwiftUI
import SwifterSwiftUI

/// Item to represent each separator between steps
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct Separator<Element>: View {
    /// Get step object for the set index
    var step: Step

    /// The main state
    @EnvironmentObject var state: StepsState<Element>

    /// The style of the component
    @EnvironmentObject var config: Config

    /// Previous index
    @State private var previousIndex: Int = 0

    /// Current scale to be animated
    @State private var scaleX: CGFloat = 1

    /// Min scale in the axis X
    private let minScaleX: CGFloat = 0.25

    /// Helper to inspect
    let inspection = Inspection<Self>()

    private var stepState: Step.State {
        return state.stateFor(step: step)
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

        if (previousIndex == step.index && diff > 0) {
            scaleX = minScaleX
        } else if (nextIndex == step.index && diff < 0) {
            scaleX = minScaleX
        } else {
            scaleX = 1
        }
    }

    private func onCompletionEffect() {
        if self.scaleX != 1 {
            scaleX = 1
        }
    }

    var body: some View {
        Container {
            Rectangle()
                .frame(height: config.lineThickness)
        }
        .foregroundColor(foregroundColor)
        .modifier(
            ScaleXEffect(
                scaleX: scaleX,
                onCompletion: onCompletionEffect
            )
        )
        .animation(config.animation)
        .onReceive(state.$currentIndex, perform: { (nextIndex) in
            self.updateScale(nextIndex: nextIndex)
            self.previousIndex = nextIndex
        })
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

#if DEBUG
struct Separator_Previews: PreviewProvider {
    static var previews: some View {
        let steps = ["First", "", ""]
        let state = StepsState(data: steps)
        return (
            Steps(state: state, onCreateStep: { element in
                Step(title: element)
            }).padding()
        )
    }
}
#endif
