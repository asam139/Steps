//
//  Container.swift
//  Steps
//
//  Created by Saul Moreno Abril on 05/04/2020.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import SwiftUI
import SwifterSwiftUI

/// Container for each subview of the bar
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct Container<Content>: View where Content: View {
    /// The style of the component
    @EnvironmentObject var config: Config

    /// The title of the subcomponent
    var title: String?

    /// The content of the container
    var content: Content

    /// Helper to inspect
    let inspection = Inspection<Self>()

    /// Initializes a new step container
    ///
    /// - Parameters:
    ///   - title: title
    ///   - content: content of the container
    public init(title: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(spacing: config.size * 0.75) {
            VStack {
                content
            }
            .frame(height: config.size + 2 * config.figurePadding)
            if let title {
                Text(title)
                    .fixedSize(horizontal: true, vertical: false)
                    .lineLimit(1)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

#if DEBUG
struct Container_Previews: PreviewProvider {
    static var previews: some View {
        Container {
            Text("Testing")
        }
    }
}
#endif
