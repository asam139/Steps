//
//  ContentView.swift
//  iOS Example
//
//  Created by Saul Moreno Abril on 10/04/2020.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import SwiftUI
import Steps

struct ContentView: View {
    @ObservedObject private var stepsState: StepsState

    @State var color = Color.red

    init() {
        let steps = [
            Step(title: "First_", image: Image(systemName: "wind")),
            Step(),
            Step(title: "Second__", image: Image(systemName: "tornado")),
            Step(),
            Step(title: "Fifth_____", image: Image(systemName: "hurricane"))
        ]
        stepsState = StepsState(steps: steps, initialStep: 1)
    }

    var body: some View {
        VStack(spacing: 12) {
            Steps(state: stepsState)
                .itemSpacing(10)
                .primaryColor(color)
                .font(.caption)
                .padding()

            Button(action: {
                self.stepsState.nextStep()
                self.color = .yellow
            }) {
                Text("Next")
            }
            .disabled(!stepsState.hasNext)
            Button(action: {
                self.stepsState.previousStep()
            }) {
                Text("Previous")
            }
            .disabled(!stepsState.hasPrevious)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
