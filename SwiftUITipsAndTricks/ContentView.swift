//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

final class ContentViewModel: ObservableObject {
    private var cancellableSet: Set<AnyCancellable> = []
    @Published var randomValue: Int = 0
    
    private var generator = PassthroughSubject<Int, Never>()
    
    init() {
        generator
            .delay(for: 1, scheduler: RunLoop.main)
            .sink { [self] random in
                randomValue = random
            }.store(in: &cancellableSet)
    }
    
    func generate() {
        generator
            .send((1...1000).randomElement() ?? 0)
    }
}

struct ContentView: View {

    @ObservedObject
    private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Random value: \(viewModel.randomValue)")
            Button {
                viewModel.generate()
            } label: {
                Text("Generate")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
