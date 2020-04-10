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
    var size: CGFloat
    var title: String?
    var content: Content

    public init(size: CGFloat = 14, title: String? = nil, @ViewBuilder content: () -> Content) {
        self.size = size
        self.title = title
        self.content = content()
    }

    var figurePadding: CGFloat {
        return size * 0.5
    }

    var body: some View {
        VStack(spacing: size * 0.75) {
            VStack {
                content
            }
            .frame(height: size + 2 * figurePadding)
            ifLet(title, then: { Text($0) })
        }
    }
}

struct StepContainer_Previews: PreviewProvider {
    static var previews: some View {
        StepContainer {
            Text("Testing")
        }
    }
}
