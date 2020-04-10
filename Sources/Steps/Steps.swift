import SwiftUI
import Combine

struct Step: Identifiable {
    var id = UUID()
    var title: String?
    var image: Image?
}

enum StepState: Int, CaseIterable {
    case uncompleted
    case current
    case completed
}

class StepsConfiguration: ObservableObject {
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

class StepsState: ObservableObject {
    let steps: [Step]
    @Published private(set) var currentIndex: Int = 0

    init(steps: [Step]) {
        self.steps = steps
    }

    func nextStep() {
        if (currentIndex > steps.count - 1) {
            return
        }
        currentIndex += 1
    }

    func previousStep() {
        if (currentIndex == 0) {
            return
        }
        currentIndex -= 1
    }
}

struct Steps: View {

    var config: StepsConfiguration = StepsConfiguration()
    @ObservedObject var state: StepsState

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

    func getColorFor(state: StepState) -> Color {
        switch state {
        case .uncompleted,
             .current:
            return config.disabledColor
        default:
            return config.primaryColor
        }
    }

    private func makeStepAt(index: Int) -> some View {
        let step = state.steps[index]
        return StepElement(step: step,
                           index: index,
                           state: state)
    }

    private func makeSeparatorAt(index: Int) -> some View {
        let statee = getStateByStepAt(index: index)
        let step = state.steps[index]
        return StepSeparator(step: step, state: statee, index: index)
    }

    var body: some View {
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
