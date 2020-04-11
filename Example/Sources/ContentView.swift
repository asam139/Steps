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
    private var config: StepsConfig

    init() {
        let steps = [
            Step(title: "First", image: Image("wind")),
            Step(),
            Step(title: "Third", image: Image("tornado")),
            Step(),
            Step(title: "Fifth", image: Image("hurricane"))
        ]
        stepsState = StepsState(steps: steps)
        config = StepsConfig()
    }

    var body: some View {
        VStack(spacing: 12) {
            Steps(state: stepsState, config: config).padding()
            Button(action: {
                self.stepsState.nextStep()
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
