import SwiftUI
import Combine
import SwifterSwiftUI

/// 🏄‍♂️ A navigation bar that guides users through the steps of a task.
public struct Steps: View {
    /// The main state of the component
    @ObservedObject public private(set) var state: StepsState

    /// The style of the component
    private var config = Config()

    /// Helper to inspect
    let inspection = Inspection<Self>()

    /// Initializes a new steps component with the initial state and config.
    ///
    /// - Parameters:
    ///   - state: Initial state.
    ///   - config: Initial config.
    public init(state: StepsState) {
        self.state = state
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
        HStack(alignment: .top, spacing: config.itemSpacing) {
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

// MARK: Mutable
extension Steps {
    /// Adds space between each page
    ///
    /// - Parameter value: Spacing between elements
    public func itemSpacing(_ value: CGFloat) -> Self {
        config.itemSpacing = value
        return self
    }

    /// Modify size of each step element
    ///
    /// - Parameter value: Size of each step element
    public func size(_ value: CGFloat) -> Self {
        config.size = value
        return self
    }

    /// Modify the line thickness of all elements
    ///
    /// - Parameter value: Line thickness of all elements
    public func lineThickness(_ value: CGFloat) -> Self {
        config.lineThickness = value
        return self
    }

    /// Modify color for current and completed steps
    ///
    /// - Parameter value: Color for current and completed steps
    public func primaryColor(_ value: Color) -> Self {
        config.primaryColor = value
        return self
    }

    /// Modify color for text inside step element
    ///
    /// - Parameter value: Color for text inside step element
    public func secondaryColor(_ value: Color) -> Self {
        config.secondaryColor = value
        return self
    }

    /// Modify color for text inside step element
    ///
    /// - Parameter value: Color for uncompleted steps
    public func disabledColor(_ value: Color) -> Self {
        config.disabledColor = value
        return self
    }

    /// Modify color for text inside step element
    ///
    /// - Parameter value: Color for uncompleted steps
    public func defaultImage(_ value: Image) -> Self {
        config.defaultImage = value
        return self
    }
}
