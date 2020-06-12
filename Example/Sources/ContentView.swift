//
//  ContentView.swift
//  iOS Example
//
//  Created by Saul Moreno Abril on 10/04/2020.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import SwiftUI
import Steps

struct BasketItem: Equatable {
    var title: String
    var image: Image?
}

struct ContentView: View {
    @ObservedObject private var stepsState: StepsState<BasketItem>

    @State var color = Color.red

    init() {
        let items = [
            BasketItem(title: "First_", image: Image(systemName: "wind")),
            BasketItem(title: ""),
            BasketItem(title: "Second__", image: Image(systemName: "tornado")),
            BasketItem(title: ""),
            BasketItem(title: "Fifth_____", image: Image(systemName: "hurricane"))
        ]
        stepsState = StepsState(data: items)
    }

    func onCreateStep(_ basketItem: BasketItem) -> Step {
        return Step(title: basketItem.title, image: basketItem.image)
    }

    var body: some View {
        VStack(spacing: 12) {
            Steps(state: stepsState, onCreateStep:onCreateStep)
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
