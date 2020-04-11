//
//  StepsState.swift
//
//
//  Created by Saul Moreno Abril on 11/04/2020.
//

import Combine

public class StepsState: ObservableObject {
    public let steps: [Step]
    @Published public private(set) var currentIndex: Int = 0

    public init(steps: [Step]) {
        self.steps = steps
    }

    public func nextStep() {
        if (currentIndex > steps.count - 1) {
            return
        }
        currentIndex += 1
    }

    public func previousStep() {
        if (currentIndex == 0) {
            return
        }
        currentIndex -= 1
    }

    func stepStateFor(index: Int) -> Step.State {
        if (index < currentIndex) {
            return .completed
        } else if index == currentIndex {
            return .current
        }
        return .uncompleted
    }

    func stepAtIndex(index: Int) -> Step {
        return steps[index]
    }
}
