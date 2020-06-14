//
//  ContentView.swift
//  iOS Example
//
//  Created by Saul Moreno Abril on 10/04/2020.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import SwiftUI
import Steps

struct Item {
    var title: String
    var image: Image?
}

struct ContentView: View {
    @ObservedObject private var stepsState: StepsState<Item>

    init() {
        let items = [
            Item(title: "First_", image: Image(systemName: "wind")),
            Item(title: ""),
            Item(title: "Second__", image: Image(systemName: "tornado")),
            Item(title: ""),
            Item(title: "Fifth_____", image: Image(systemName: "hurricane"))
        ]
        stepsState = StepsState(data: items)
    }

    func onCreateStep(_ item: Item) -> Step {
        return Step(title: item.title, image: item.image)
    }

    var body: some View {
        VStack(spacing: 12) {
            Steps(state: stepsState, onCreateStep:onCreateStep)
                .itemSpacing(10)
                .font(.caption)
                .padding()

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
