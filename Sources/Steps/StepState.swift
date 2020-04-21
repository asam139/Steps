//
//  StepState.swift
//  Steps
//
//  Created by Saul Moreno Abril on 21/04/2020.
//

import Foundation

/// State in which can be found a step
enum StepState: Int, CaseIterable {
    /// State for uncompleted step
    case uncompleted

    /// State for the current step
    case current

    /// State for completed step
    case completed
}
