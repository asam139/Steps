//
//  Step.swift
//
//
//  Created by Saul Moreno Abril on 10/04/2020.
//

import SwiftUI

/// Represents a new step in the component
public struct Step: Identifiable {
    public var id = UUID()
    public var title: String?
    public var image: Image?

    /// Initializes a new step.
    ///
    /// - Parameters:
    ///   - title: title of the step
    ///   - config: image of the step
    public init(title: String? = nil, image: Image? = nil) {
        self.title = title
        self.image = image
    }
}
