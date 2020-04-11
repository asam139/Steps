//
//  StepSeparator.swift
//  curlyhair
//
//  Created by Saul Moreno Abril on 09/04/2020.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import SwiftUI
import SwifterSwiftUI

struct StepSeparator: View {
    @EnvironmentObject var config: StepsConfig

    var index: Int
    @ObservedObject var state: StepsState

    @State private var previousIndex: Int = 0
    @State private var scaleX: CGFloat = 1

    private var stepState: Step.State {
        return state.stepStateFor(index: index)
    }

    private var foregroundColor: Color {
        switch stepState {
        case .uncompleted,
             .current:
            return config.disabledColor
        default:
            return config.primaryColor
        }
    }

    private func updateScale(nextIndex: Int) {
        let diff = nextIndex - previousIndex
        if abs(diff) != 1 {
            scaleX = 1
            return
        }

        if (previousIndex == index && diff > 0) {
            scaleX = 0
        } else if (nextIndex == index && diff < 0) {
            scaleX = 0
        } else {
            scaleX = 1
        }
    }

    var body: some View {
        let duration = 0.55
        let animation = Animation
            .spring(response: duration, dampingFraction: 0.45, blendDuration: 0)

        return (
            StepContainer(size: config.size) {
                Rectangle()
                    .frame(height: config.lineThickness)
                    .scaleEffect(x: scaleX, y: 1, anchor: .center)
                    .animation(animation)
                    .onReceive(state.$currentIndex, perform: { (nextIndex) in
                        self.updateScale(nextIndex: nextIndex)
                        let previousScaleX = self.scaleX
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            if (self.scaleX != 1 && previousScaleX == self.scaleX) {
                                self.scaleX = 1
                            }
                        }
                        self.previousIndex = nextIndex
                    })
            }
            .foregroundColor(foregroundColor)
        )
    }
}

struct StepSeparator_Previews: PreviewProvider {
    static var previews: some View {
        let steps = [Step(title: "First"), Step(), Step()]
        let state = StepsState(steps: steps)
        return StepSeparator(index: 0, state: state).environmentObject(StepsConfig())
    }
}
