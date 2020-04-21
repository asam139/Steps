//
//  StepElement.swift
//  curlyhair
//
//  Created by Saul Moreno Abril on 09/04/2020.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import SwiftUI
import SwifterSwiftUI

/// Element to represent each step
struct StepElement: View {
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

    /// Current offset to be animated
    @State private var offset: CGFloat = 0

    /// Get current step state  for the set index
    private var stepState: StepState {
        return state.stepStateFor(index: index)
    }

    /// Get step object for the set index
    private var step: Step {
        return state.stepAtIndex(index: index)
    }

    /// Get image for the current step
    private var image: Image? {
        return stepState != .completed ? step.image : config.image
    }

    /// Get foreground color for the current step
    private var foregroundColor: Color {
        switch stepState {
        case .uncompleted:
            return config.disabledColor
        default:
            return config.primaryColor
        }
    }

    /// Max diff offset to be animated
    private var maxOffset: CGFloat {
        return config.spacing * 2
    }

    /// Update the offset to animate according the next index
    private func updateOffset(nextIndex: Int) {
        let diff = nextIndex - previousIndex
        if abs(diff) != 1 {
            offset = 0
            return
        }

        if ((previousIndex == state.steps.endIndex && diff > 0) ||
            (nextIndex == state.steps.endIndex && diff < 0)) {
            offset = 0
        } else if (previousIndex == index) {
            offset = CGFloat(diff) * maxOffset
        } else if(nextIndex == index) {
            offset = -CGFloat(diff) * maxOffset
        } else {
            offset = 0
        }
    }

    var body: some View {
        StepContainer(title: step.title) {
            ifLet(image, then: {
                $0.resizable()
            }, else: {
                Text("\(index + 1)").font(.system(size: config.size))
            })
                .frame(width: config.size, height: config.size)
                .padding(config.figurePadding)
                .if(index == state.currentIndex, then: {
                    $0.background(config.primaryColor).foregroundColor(config.secondaryColor)
                }, else: {
                    $0.overlay(
                        Circle().stroke(lineWidth: config.lineThickness)
                    )
                })
                .cornerRadius(config.size)
        }
        .foregroundColor(foregroundColor)
        .modifier(OffsetEffect(offset: offset, pct: abs(offset) > 0 ? 1 : 0))
        .animation(config.animation)
        .onReceive(state.$currentIndex, perform: { (nextIndex) in
            self.updateOffset(nextIndex: nextIndex)
            let previousOffset = self.offset
            DispatchQueue.main.asyncAfter(deadline: .now() + self.config.animationDuration) {
                if (self.offset != 0 && previousOffset == self.offset) {
                    self.offset = 0
                }
            }
            self.previousIndex = nextIndex
        })
            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

#if DEBUG
struct StepElement_Previews: PreviewProvider {
    static var previews: some View {
        let steps = [Step(title: "First"), Step(), Step()]
        let state = StepsState(steps: steps)
        return StepElement(index: 0, state: state)
    }
}
#endif
