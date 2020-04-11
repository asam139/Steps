//
//  StepsConfig.swift
//
//
//  Created by Saul Moreno Abril on 11/04/2020.
//

import SwiftUI
import Combine

public class StepsConfig: ObservableObject {
    public var spacing: CGFloat = 5
    public var size: CGFloat = 14
    public var lineThickness: CGFloat = 2

    public var primaryColor: Color = Color.blue
    public var secondaryColor: Color = Color.white
    public var disabledColor: Color = Color.gray

    #if os(iOS)
    public var image: Image? = Image(systemName: "checkmark")
    #endif

    #if os(macOS)
    public var image: Image?
    #endif

    let animationDuration: TimeInterval = 0.55
    var animation: Animation {
        return Animation.spring(response: animationDuration, dampingFraction: 0.45, blendDuration: 0)
    }

    public init() {

    }
}
