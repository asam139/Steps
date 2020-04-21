import SwiftUI
import Combine

/// 🏄‍♂️ A navigation bar that guides users through the steps of a task.
public struct Steps: View {
    /// The main state of the component
    @ObservedObject public private(set) var state: StepsState

    /// The style of the component
    public private(set) var config: StepsConfig

    /// Helper to inspect
    let inspection = Inspection<Self>()

    /// Initializes a new steps component with the initial state and config.
    ///
    /// - Parameters:
    ///   - state: Initial state.
    ///   - config: Initial config.
    public init(state: StepsState, config: StepsConfig = StepsConfig()) {
        self.state = state
        self.config = config
    }

    /// Initializes a new step element.
    ///
    /// - Parameters:
    ///   - index: index of the step
    private func makeStepAt(index: Int) -> some View {
        return StepElement(index: index, state: state)
    }

    /// Initializes a new step element.
    ///
    /// - Parameters:
    ///   - index: index of the step
    private func makeSeparatorAt(index: Int) -> some View {
        return StepSeparator(index: index, state: state)
    }

    public var body: some View {
        HStack(alignment: .top, spacing: config.spacing) {
            ForEach(state.steps.indices) { index in
                self.makeStepAt(index: index)
                if (index < self.state.steps.endIndex - 1) {
                    self.makeSeparatorAt(index: index)
                }
            }
        }
        .environmentObject(config)
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

#if DEBUG
struct Steps_Previews: PreviewProvider {
    static var previews: some View {
        let steps = [Step(title: "First"), Step(), Step()]
        let state = StepsState(steps: steps)
        return (
            Steps(state: state).padding()
        )
    }
}
#endif
