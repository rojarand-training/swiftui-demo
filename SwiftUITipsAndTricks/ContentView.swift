//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine


class ContentViewModel: ObservableObject {
    
    @Published var randomValue: Int = 0
    
    private var cancellables: AnyCancellable?
    
    func generateRandomValue() {
        cancellables = Just<Int>(Int.random(in: 0...100))
            .delay(for: 1, scheduler: RunLoop.main)
            .sink { [weak self] random in
                self?.randomValue = random
            }
    }
}

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Random value: \(viewModel.randomValue)")
            Button("Generate random value") {
                viewModel.generateRandomValue()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
