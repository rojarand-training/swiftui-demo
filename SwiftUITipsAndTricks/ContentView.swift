//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var counter: Int
    
    init() {
        counter = 0
    }
    
    func increment() {
        counter += 1
    }
}

struct PersistentCounterView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    var body: some View {
        VStack {
            Text("This is persistent counter - @StateObject")
            HStack {
                Button {
                    viewModel.increment()
                } label: {
                    Text("Increment")
                }
                Text("\(viewModel.counter)")
            }
        }
        .frame(maxWidth: .infinity)
        .background(.green)
    }
}

struct VolatileCounterView: View {
    
    @ObservedObject private var viewModel = ContentViewModel()
    var body: some View {
        VStack {
            Text("This is volatile counter - @ObservedObject")
            HStack {
                Button {
                    viewModel.increment()
                } label: {
                    Text("Increment")
                }
                Text("\(viewModel.counter)")
            }
        }
        .frame(maxWidth: .infinity)
        .background(.orange)
    }
}

struct ContentView: View {
    @State var randomNumber = 0

    var body: some View {
        VStack {
            Text("Active: \(randomNumber)")
            Button {
                randomNumber = (0..<1000).randomElement() ?? 0
            } label: {
                Text("Reset view")
            }
            PersistentCounterView()
            VolatileCounterView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
