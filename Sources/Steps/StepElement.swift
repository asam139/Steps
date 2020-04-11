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

        if (previousIndex == index) {
            if (previousIndex == state.steps.count - 1 && diff > 0) {
                offset = 0
            } else {
                offset = CGFloat(diff) * maxOffset
            }

        } else if(nextIndex == index) {
            if (nextIndex == state.steps.count - 1 && diff < 0) {
                offset = 0
            } else {
                offset = -CGFloat(diff) * maxOffset
            }
        } else {
            offset = 0
        }
    }

    var body: some View {
        let duration = 0.55
        let animation = Animation
            .spring(response: duration, dampingFraction: 0.45, blendDuration: 0)

        return (
            StepContainer(size: config.size, title: step.title) {
                ifLet(image, then: {
                    $0.resizable()
                }, else: {
                    Text("\(index + 1)")
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
                    .animation(animation)
            }
            .foregroundColor(foregroundColor)
            .modifier(StepOffsetEffect(offset: offset, pct: abs(offset) > 0 ? 1 : 0))
            .animation(animation)
            .onReceive(state.$currentIndex, perform: { (nextIndex) in
                let previousOffset = self.offset
                self.updateOffset(nextIndex: nextIndex)
                if (self.offset != 0 && previousOffset != self.offset) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        self.offset = 0
                    }
                }
                self.previousIndex = nextIndex
            })
        )
    }
}

struct StepOffsetEffect: GeometryEffect {
    var offset: CGFloat
    var pct: CGFloat
    var offsetDiff: CGFloat = 0

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
        let factor: CGFloat = 0.25
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

struct StepElement_Previews: PreviewProvider {

    static var previews: some View {
        let steps = [Step(title: "First"), Step(), Step()]
        let state = StepsState(steps: steps)
        return StepElement(index: 0, state: state)
    }
}
