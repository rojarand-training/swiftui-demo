//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine



final class ContentViewModel: ObservableObject {
    
    @Published var mergeResult: String = ""
    @Published var zipResult: String = ""
   
    private let letterSubject = PassthroughSubject<Character, Never>()
    private let digitSubject = PassthroughSubject<Int, Never>()
   
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        letterSubject
            .map{ character in
                String(character)
            }
            .merge(with: digitSubject.map { value in "\(value)" })
            .sink { value in
                self.mergeResult += (self.mergeResult.isEmpty ? "" : ", ") + "\(value)"
            }
            .store(in: &cancellables)
        

        letterSubject
            .zip(digitSubject)
            .sink { (value1, value2) in
                self.zipResult += (self.zipResult.isEmpty ? "" : ", ") + "(\(value1),\(value2))"
            }
            .store(in: &cancellables)
    }
    
    func drawNextLetter() {
        let charMin = Character("A").asciiValue!
        let charMax = Character("Z").asciiValue!
        let randomASCII = UInt8.random(in: (charMin...charMax))
        let result = Character(UnicodeScalar(randomASCII))
        print("New letter: \(result)")
        letterSubject.send(result)
    }
    
    func drawNextDigit() {
        let result = Int.random(in: (1...9))
        print("New digit: \(result)")
        digitSubject.send(result)
    }
}

struct ContentView: View {
    
    @ObservedObject private var vm = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Merge result: \(vm.mergeResult)")
            Text("Zip result: \(vm.zipResult)")
            Button("Draw next digit") {
                vm.drawNextDigit()
            }
            Button("Draw next letter") {
                vm.drawNextLetter()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
