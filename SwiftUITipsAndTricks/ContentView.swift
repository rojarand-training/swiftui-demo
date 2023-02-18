//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

struct Tokenizer {
    func tokenize(sentence: String) -> AnyPublisher<[String], Never> {
        Just(sentence)
            .subscribe(on: DispatchQueue.global())
            .map { sentence in
                print("Is main thread: \(Thread.isMainThread)")
                return sentence.split(separator: " ")
                .map { substring in
                    String(substring)
                }
            }
            .eraseToAnyPublisher()
    }
}

final class ContentViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var tokens: [String] = []
   
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        tokenPublisher.sink { tokens in
            self.tokens = tokens
        }.store(in: &cancellables)
    }
    
    var tokenPublisher: AnyPublisher<[String], Never> {
        $text
            .debounce(for: 0.5, scheduler: DispatchQueue.global())
            .removeDuplicates()
            .flatMap(Tokenizer().tokenize)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension String: Identifiable {
    public var id: String { self }
}

struct ContentView: View {

    @ObservedObject private var vm = ContentViewModel()
    var body: some View {
        VStack {
            TextField("Type a sentence", text: $vm.text)
            List(vm.tokens) { text in
                Text(text)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
