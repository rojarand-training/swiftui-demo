//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

struct UnexpectedNilReceived: Error {}

extension Publisher {
    func unwrap<T, E: Error>(orThrow error: @escaping @autoclosure () -> E) -> Publishers.TryMap<Self, T>
    where Output==Optional<T> {
        return tryMap { output in
            switch output {
            case .some(let value):
                return value
            default:
                throw error()
            }
        }
    }
}

final class ContentViewModel: ObservableObject {
    
    @Published var resultValue: String = ""
    @Published var resultDescription: String = ""
    private var cancellable: Cancellable?
    
    private func drawEvenNumber() -> Int? {
        let value = Int.random(in: 1...100)
        return value%2 == 0 ? value : nil
    }
    
    func compute() {
        cancellable = Just<Int?>( drawEvenNumber() )
            .unwrap(orThrow: UnexpectedNilReceived())
            .sink { result in
                self.resultDescription = "Result: \(result)"
            } receiveValue: { value in
                self.resultValue = "\(value)"
            }
    }
}

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Result value: \(viewModel.resultValue)")
            Text("Result description: \(viewModel.resultDescription)")
            Button("Compute result ") {
                viewModel.compute()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
