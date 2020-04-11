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
    @Published public private(set) var hasNext: Bool = true
    @Published public private(set) var hasPrevious: Bool = true

    private var cancellable: AnyCancellable?

    public init(steps: [Step]) {
        self.steps = steps

        cancellable = $currentIndex.sink { (index) in
            self.hasNext = index < self.steps.endIndex
            self.hasPrevious = index > self.steps.startIndex
        }
    }

    public func nextStep() {
        if (currentIndex > steps.endIndex) {
            return
        }
        currentIndex += 1
    }

    public func previousStep() {
        if (currentIndex == steps.startIndex) {
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
