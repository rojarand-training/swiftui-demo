//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine


final class ContentViewModel: ObservableObject {
   
    @Published var result: String = ""
    private let subject = PassthroughSubject<Int, Never>()
    private var cancellables: AnyCancellable?
    
    init() {
        cancellables = subject
            .map { divider in
                (1...100).filter { value in
                    (value % divider) == 0
                }.publisher
                    .collect()
                    .delay(for: 1, scheduler: DispatchQueue.main)
            }
            .switchToLatest()
            .map({ res in
                "\(res)"
            })
            .assign(to: \.result, on: self)
    }
    
    func dividable(by divider: Int) {
        subject.send(divider)
    }
}

struct ContentView: View {
    
    @ObservedObject private var vm = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Show numbers dividible by: ")
            HStack {
                Button {
                    vm.dividable(by: 2)
                } label: {
                    Text("2")
                        .roundedCornersButton()
                }
                
                Button {
                    vm.dividable(by: 3)
                } label: {
                    Text("3")
                        .roundedCornersButton()
                }
                
                Button {
                    vm.dividable(by: 5)
                } label: {
                    Text("5")
                        .roundedCornersButton()
                }
                
                Button {
                    vm.dividable(by: 7)
                } label: {
                    Text("7")
                        .roundedCornersButton()
                }
            }
            Text("Result: \(vm.result)")
        }
    }
}

extension View {
    func roundedCornersButton() -> some View {
        return self.modifier(RoundedCornerButton())
    }
}

struct RoundedCornerButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding()
            .background(.green)
            .cornerRadius(12)
            .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
