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

    init() {
        let steps = [Step(), Step(), Step(), Step(), Step()]
        stepsState = StepsState(steps: steps)
    }

    var body: some View {
        VStack {
            Steps(state: stepsState).padding()
            Button(action: {
                self.stepsState.nextStep()
            }) {
                Text("\(stepsState.currentIndex)")
            }
            Button(action: {
                self.stepsState.previousStep()
            }) {
                Text("\(stepsState.currentIndex)")
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
