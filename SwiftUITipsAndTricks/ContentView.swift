//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

struct PositiveIntRequired: Error {
}

class ContentViewModel: ObservableObject {
    
    @Published var receivedResult: String = ""
    @Published var receivedValue: String = ""
    
    private var cancellable: Cancellable?
    
    func refresh() {
        cancellable = multiply(value: Int.random(in: -1...2))
            .sink { result in
                self.receivedResult = "\(result)"
            } receiveValue: { value in
                self.receivedValue = "\(value)"
            }
    }
    
    func multiply(value: Int) -> AnyPublisher<Int, Error> {
        guard value>0 else {
            return Fail(error: PositiveIntRequired()).eraseToAnyPublisher()
        }
        /*Cannot convert return expression of type 'AnyPublisher<Int, Never>' to return type 'AnyPublisher<Int, any Error>'
        return Just(value*2).eraseToAnyPublisher()
         */
        
        return Just(value*2)
            .setFailureType(to: Error.self) //we need to specify failure type
            .eraseToAnyPublisher()
    }
}

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Result type: \(viewModel.receivedResult)")
            Text("Result value: \(viewModel.receivedValue)")
            Button("Refresh") {
                viewModel.refresh()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
