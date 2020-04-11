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
    public var image: Image? = nil
    #endif
}
