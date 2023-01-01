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
    @Published var randomValue: String = ""
    
    private var integerGenerator = PassthroughSubject<Int, Never>()
    private var stringGenerator = PassthroughSubject<String, Never>()
    
    init() {
        
        let delayedStringGenerator = stringGenerator
            .delay(for: 1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
        
        integerGenerator.zip(delayedStringGenerator)
            .sink { (generatedInteger, generatedString) in
                self.randomValue = "\(generatedInteger) - \(generatedString)"
            }
            .store(in: &cancellableSet)
    }
    
    func generate() {
        integerGenerator.send(generateInteger())
        stringGenerator.send("\(generateInteger())")
    }
    
    private func generateInteger() -> Int {
        return (1...1000).randomElement() ?? 0
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
