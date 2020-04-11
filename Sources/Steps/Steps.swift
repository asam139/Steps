import SwiftUI
import Combine

public struct Steps: View {
    @ObservedObject public private(set) var state: StepsState
    public private(set) var config: StepsConfig

    public init(state: StepsState, config: StepsConfig = StepsConfig()) {
        self.state = state
        self.config = config
    }

    private func makeStepAt(index: Int) -> some View {
        return StepElement(index: index, state: state)
    }

    private func makeSeparatorAt(index: Int) -> some View {
        return StepSeparator(index: index, state: state)
    }

    public var body: some View {
        VStack {
            HStack(alignment: .top, spacing: config.spacing) {
                ForEach(state.steps.indices) { index in
                    self.makeStepAt(index: index)
                    if (index < self.state.steps.endIndex - 1) {
                        self.makeSeparatorAt(index: index)
                    }
                }
            }
        }.environmentObject(config)
    }
}

struct Steps_Previews: PreviewProvider {
    static var previews: some View {
        let steps = [Step(title: "First"), Step(), Step()]
        let state = StepsState(steps: steps)
        return (
            Steps(state: state).padding()
        )
    }
}
