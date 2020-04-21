//
//  StepsState.swift
//
//
//  Created by Saul Moreno Abril on 11/04/2020.
//

import Combine

public class StepsState: ObservableObject {
    /// Array of all steps
    public let steps: [Step]

    /// Indicate the current step
    @Published public private(set) var currentIndex: Int = 0

    /// Indicate if there is a next step
    @Published public private(set) var hasNext: Bool = true

    /// Indicate if there is a previous step
    @Published public private(set) var hasPrevious: Bool = true

    /// Set to store all cancellables
    private var cancellable: AnyCancellable?

    /// Initializes a new state.
    ///
    /// - Parameters:
    ///   - steps: array of all steps
    public init(steps: [Step], initialStep: Int = 0) {
        self.steps = steps
        if (initialStep >= steps.startIndex && initialStep <= steps.endIndex) {
            currentIndex = initialStep
        }

        cancellable = $currentIndex.sink { (index) in
            self.hasNext = index < self.steps.endIndex
            self.hasPrevious = index > self.steps.startIndex
        }
    }

    /// Move to the next step
    public func nextStep() {
        if (currentIndex > steps.endIndex) {
            return
        }
        currentIndex += 1
    }

    /// Move to the previous step
    public func previousStep() {
        if (currentIndex == steps.startIndex) {
            return
        }
        currentIndex -= 1
    }

    /// Get state for step at an index
    func stepStateFor(index: Int) -> StepState {
        if (index < currentIndex) {
            return .completed
        } else if index == currentIndex {
            return .current
        }
        return .uncompleted
    }

    /// Get step in an index
    func stepAtIndex(index: Int) -> Step {
        return steps[index]
    }
}
