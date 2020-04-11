//
//  StepElement.swift
//  curlyhair
//
//  Created by Saul Moreno Abril on 09/04/2020.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import SwiftUI
import SwifterSwiftUI

struct StepElement: View {
    @EnvironmentObject var config: StepsConfig

    var index: Int
    @ObservedObject var state: StepsState

    @State private var previousIndex: Int = 0
    @State private var offset: CGFloat = 0

    private var stepState: Step.State {
        return state.stepStateFor(index: index)
    }

    private var step: Step {
        return state.stepAtIndex(index: index)
    }

    private var image: Image? {
        return stepState != .completed ? step.image : config.image
    }

    private var foregroundColor: Color {
        switch stepState {
        case .uncompleted:
            return config.disabledColor
        default:
            return config.primaryColor
        }
    }

    private var figurePadding: CGFloat {
        return config.size * 0.5
    }

    private var maxOffset: CGFloat {
        return config.spacing * 2
    }

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
        StepContainer(size: config.size, title: step.title) {
            ifLet(image, then: {
                $0.resizable()
            }, else: {
                Text("\(index + 1)").font(.system(size: config.size))
            })
                .frame(width: config.size, height: config.size)
                .padding(figurePadding)
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
    }
}

struct StepElement_Previews: PreviewProvider {

    static var previews: some View {
        let steps = [Step(title: "First"), Step(), Step()]
        let state = StepsState(steps: steps)
        return StepElement(index: 0, state: state)
    }
}
