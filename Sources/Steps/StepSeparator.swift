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
    @EnvironmentObject var config: StepsConfiguration

    var step: Step
    var state: StepState
    var index: Int

    private var figurePadding: CGFloat {
        return config.size * 0.5
    }

    func getColorFor(state: StepState) -> Color {
        switch state {
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
        .foregroundColor(getColorFor(state: state))
    }
}

struct StepSeparator_Previews: PreviewProvider {
    static var previews: some View {
        StepSeparator(step: Step(), state: .uncompleted, index: 0)
    }
}
