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

    var body: some View {
        StepContainer(size: config.size) {
            Rectangle()
                .frame(height: config.lineThickness)
        }
        .foregroundColor(foregroundColor)
    }
}

struct StepSeparator_Previews: PreviewProvider {
    static var previews: some View {
        let steps = [Step(title: "First"), Step(), Step()]
        let state = StepsState(steps: steps)
        return StepSeparator(index: 0, state: state).environmentObject(StepsConfig())
    }
}
