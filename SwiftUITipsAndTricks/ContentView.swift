//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

final class ContentViewModel: ObservableObject {
    
    @Published var history: String = ""
    var currentText: String = ""
    
    private var subject = CurrentValueSubject<String, Error>("")
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = subject
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .filter({ string in
                string.count > 1
            })
            .scan("") { nextPartialResult, newString in
            nextPartialResult + "\n "+newString
        }.sink(receiveCompletion: { completion in
            
        }, receiveValue: { string in
            self.history = string
        })
    }
    
    func updateCurrentText(newText: String) {
        currentText = newText
        subject.send(newText)
    }
}

struct ContentView: View {

    @ObservedObject private var vm: ContentViewModel
    
    init() {
        vm = ContentViewModel()
    }
    
    var body: some View {
        VStack {
            TextField("Type something", text: text)
            Text(vm.history)
        }
    }
    
    var text: Binding<String> {
        Binding {
            self.vm.currentText
        } set: { newTxt in
            self.vm.updateCurrentText(newText: newTxt)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
