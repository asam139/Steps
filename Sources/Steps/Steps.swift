import SwiftUI
import Combine
import SwifterSwiftUI

/// 🏄‍♂️ A navigation bar that guides users through the steps of a task.
public struct Steps<Element>: View {

    /// The main state of the component
    @ObservedObject private(set) var state: StepsState<Element>

    /// Block to create each step
    let onCreateStep: (Element) -> Step

    /// The style of the component
    let config = Config()

    /// Helper to inspect
    let inspection = Inspection<Self>()

    /// Initializes a new `Steps`.
    ///
    /// - Parameter state: State to manage component
    /// - Parameter onCreateStep: Block to create each step
    public init(state: StepsState<Element>, onCreateStep: @escaping (Element) -> Step) {
        self.state = state
        self.onCreateStep = onCreateStep
    }

    /// Initializes a new separator
    ///
    /// - Parameters:
    ///   - index: index of the step
    private func renderIndex(_ index: Int) -> some View {
        let element = state.data[index]
        var step = onCreateStep(element)
        step.index = index

        let first = Item<Element>(step: step)
        var second: Separator<Element>?
        if (index < state.data.endIndex - 1) {
            second = Separator(step: step)
        }
        return ViewBuilder.buildBlock(first,second)
    }

    public var body: some View {
        HStack(alignment: .top, spacing: config.itemSpacing) {
            ForEach(state.data.indices) { index in
                self.renderIndex(index)
            }
        }
        .environmentObject(state)
        .environmentObject(config)
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

#if DEBUG
struct Steps_Previews: PreviewProvider {
    static var previews: some View {
        let steps = ["First", "", ""]
        let state = StepsState(data: steps)
        return (
            Steps(state: state, onCreateStep: { element in
                Step(title: element)
            }).padding()
        )
    }
}
#endif

// MARK: Builders
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
