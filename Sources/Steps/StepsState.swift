//
//  StepsState.swift
//
//
//  Created by Saul Moreno Abril on 11/04/2020.
//

import Combine

public class StepsState<Element>: ObservableObject {
    /// Array of items that will populate each page
    var data: [Element]

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
    public init(data: [Element], initialStep: Int = 0) {
        self.data = data

        if (initialStep >= data.startIndex && initialStep <= data.endIndex) {
            currentIndex = initialStep
        }

        cancellable = $currentIndex.sink { (index) in
            self.hasNext = index < self.data.endIndex
            self.hasPrevious = index > self.data.startIndex
        }
    }

    /// Move to the next step
    public func nextStep() {
        if (currentIndex > data.endIndex) {
            return
        }
        currentIndex += 1
    }

    /// Move to the previous step
    public func previousStep() {
        if (currentIndex == data.startIndex) {
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
}
