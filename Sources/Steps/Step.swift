//
//  Step.swift
//
//
//  Created by Saul Moreno Abril on 10/04/2020.
//

import SwiftUI

/// Represents a new step in the component
public struct Step {
    /// Title
    public var title: String?
    /// Image
    public var image: Image?

    /// State in which can be found a step
    enum State: Int, CaseIterable {
        /// State for uncompleted step
        case uncompleted

        /// State for the current step
        case current

        /// State for completed step
        case completed
    }

    /// Index
    var index: Int = 0

    /// State
    var state: State = .uncompleted

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
