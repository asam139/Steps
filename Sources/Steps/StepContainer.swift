//
//  StepContainer.swift
//  curlyhair
//
//  Created by Saul Moreno Abril on 05/04/2020.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import SwiftUI
import SwifterSwiftUI

struct StepContainer<Content> : View where Content : View {
    @EnvironmentObject var config: StepsConfig
    var title: String?
    var content: Content

    let inspection = Inspection<Self>()

    public init(title: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var figurePadding: CGFloat {
        return config.size * 0.5
    }

    var body: some View {
        VStack(spacing: config.size * 0.75) {
            VStack {
                content
            }
            .frame(height: config.size + 2 * figurePadding)
            ifLet(title, then: { Text($0) })
                .lineLimit(1)
        }.onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

#if DEBUG
struct StepContainer_Previews: PreviewProvider {
    static var previews: some View {
        StepContainer {
            Text("Testing")
        }
    }
}
#endif
