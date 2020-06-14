//
//  Config.swift
//
//
//  Created by Saul Moreno Abril on 11/04/2020.
//

import SwiftUI
import Combine

/// Object to manage the config of the main component
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
class Config: ObservableObject {

    /// Spacing between elements
    @Published var itemSpacing: CGFloat = 5

    /// Size of each step
    @Published var size: CGFloat = 14

    /// Line thickness for all lines in the component
    @Published var lineThickness: CGFloat = 2

    /// Color for current and completed steps
    @Published var primaryColor: Color = Color.blue

    /// Color for text inside step element
    @Published var secondaryColor: Color = Color.white

    /// Color for uncompleted steps
    @Published var disabledColor: Color = Color.gray

    /// Default image for completed steps
    #if os(iOS) || os(watchOS) || os(tvOS)
    @Published public var defaultImage: Image? = Image(systemName: "checkmark")
    #elseif os(OSX)
    @Published public var defaultImage: Image?
    #endif

    /// Padding to adjust subviews
    var figurePadding: CGFloat {
        return size * 0.5
    }

    /// Default animation
    var animation: Animation {
        return Animation.spring(response: 0.5, dampingFraction: 0.95, blendDuration: 0)
    }

    /// Initializes a new config.
    public init() {}
}
