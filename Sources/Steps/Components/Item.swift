//
//  Item.swift
//  Steps
//
//  Created by Saul Moreno Abril on 09/04/2020.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import SwiftUI
import SwifterSwiftUI

/// Item to represent each step
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct Item<Element>: View {
    /// Get step object for the set index
    var step: Step

    /// The main state
    @EnvironmentObject var state: StepsState<Element>

    /// The style of the component
    @EnvironmentObject var config: Config

    /// Helper to inspect
    let inspection = Inspection<Self>()

    /// Previous index
    @State private var previousIndex: Int = 0

    /// Current offset to be animated
    @State private var offset: CGFloat = 0

    /// Max diff offset to be animated
    private var maxOffset: CGFloat {
        return config.itemSpacing * 2
    }

    private var stepState: Step.State {
        return state.stateFor(step: step)
    }

    /// Get image for the current step
    private var image: Image? {
        return stepState != .completed ? step.image : config.defaultImage
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

    /// Update the offset to animate according the next index
    private func updateOffset(nextIndex: Int) {
        let diff = nextIndex - previousIndex
        if abs(diff) != 1 {
            offset = 0
            return
        }

        if
            (previousIndex == state.data.endIndex && diff > 0) ||
            (nextIndex == state.data.endIndex && diff < 0)
        {
            offset = 0
        } else if previousIndex == step.index {
            offset = CGFloat(diff) * maxOffset
        } else if nextIndex == step.index {
            offset = -CGFloat(diff) * maxOffset
        } else {
            offset = 0
        }
    }

    private func onCompletionEffect() {
        if self.offset != 0 {
            offset = 0
        }
    }

    var body: some View {
        Container(title: step.title) {
            ifLet(image, then: {
                $0.resizable()
            }, else: {
                Text("\(step.index + 1)").font(.system(size: config.size))
            })
                .frame(width: config.size, height: config.size)
                .padding(config.figurePadding)
                .if(step.index == state.currentIndex, then: {
                    $0.background(config.primaryColor).foregroundColor(config.secondaryColor)
                }, else: {
                    $0.overlay(
                        Circle().stroke(lineWidth: config.lineThickness)
                    )
                })
                .cornerRadius(config.size)
        }
        .foregroundColor(foregroundColor)
        .modifier(
            OffsetEffect(
                offset: offset,
                pct: abs(offset) > 0 ? 1 : 0,
                onCompletion: onCompletionEffect
            )
        )
            .animation(config.animation)
            .onReceive(state.$currentIndex, perform: { (nextIndex) in
                self.updateOffset(nextIndex: nextIndex)
                self.previousIndex = nextIndex
            })
            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

#if DEBUG
struct Item_Previews: PreviewProvider {
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
