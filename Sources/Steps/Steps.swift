import SwiftUI
import Combine

public class StepsConfig: ObservableObject {
    var spacing: CGFloat = 5
    var size: CGFloat = 14
    var lineThickness: CGFloat = 2

    var primaryColor: Color = Color.blue
    var secondaryColor: Color = Color.white
    var disabledColor: Color = Color.gray

    #if os(iOS)
    var image: Image? = Image(systemName: "checkmark")
    #endif

    #if os(macOS)
    var image: Image? = nil
    #endif
}

public struct Steps: View {

    var config: StepsConfig = StepsConfig()
    @ObservedObject var state: StepsState

    public init(state: StepsState) {
        self.state = state
    }

    private var figurePadding: CGFloat {
        return config.size * 0.5
    }

    func getStateByStepAt(index: Int) -> StepState {
        if (index < state.currentIndex) {
            return .completed
        } else if index == state.currentIndex {
            return .current
        }
        return .uncompleted
    }

    private func makeStepAt(index: Int) -> some View {
        let step = state.steps[index]
        return StepElement(step: step,
                           index: index,
                           state: state)
    }

    private func makeSeparatorAt(index: Int) -> some View {
        let step = state.steps[index]
        return StepSeparator(step: step, index: index, state: state)
    }

    public var body: some View {
        VStack {
            HStack(alignment: .top, spacing: config.spacing) {
                ForEach(state.steps.indices) { index in
                    self.makeStepAt(index: index)
                    if (index < self.state.steps.count - 1) {
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
