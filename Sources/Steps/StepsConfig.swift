//
//  StepsConfig.swift
//
//
//  Created by Saul Moreno Abril on 11/04/2020.
//

import SwiftUI
import Combine

/// Object to manage the config of the main component
public class StepsConfig: ObservableObject {

    /// Spacing between elements
    public var spacing: CGFloat = 5

    /// Size of each step
    public var size: CGFloat = 14

    /// Line thickness for all lines in the component
    public var lineThickness: CGFloat = 2

    /// Color for current and completed steps
    public var primaryColor: Color = Color.blue

    /// Color for text inside step element
    public var secondaryColor: Color = Color.white

    /// Color for uncompleted steps
    public var disabledColor: Color = Color.gray

    /// Default image for completed steps
    #if os(iOS) || os(watchOS) || os(tvOS)
    public var image: Image? = Image(systemName: "checkmark")
    #elseif os(OSX)
    public var image: Image?
    #endif

    /// Padding to adjust subviews
    var figurePadding: CGFloat {
        return size * 0.5
    }

    /// Default animation duration
    let animationDuration: TimeInterval = 0.55

    /// Default animation
    var animation: Animation {
        return Animation.spring(response: animationDuration, dampingFraction: 0.45, blendDuration: 0)
    }

    /// Initializes a new config.
    public init() {}
}
