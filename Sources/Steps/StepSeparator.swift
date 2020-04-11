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

    var step: Step
    var index: Int
    @ObservedObject var state: StepsState

    private var figurePadding: CGFloat {
        return config.size * 0.5
    }

    var foregroundColor: Color {
        switch state.stepStateAt(index: index) {
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
        return StepSeparator(step: Step(), index: 0, state: state)
    }
}
