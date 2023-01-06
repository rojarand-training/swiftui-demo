//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

class NonBlockingRandomStringViewModel: ObservableObject {
    @Published var content: String = ""
    var cancellable: Cancellable?
    
    func regenerate() {
        cancellable = Just(Int.random(in: 1...100))
            .subscribe(on: DispatchQueue.global())
            .map { (generated: Int) in
                print("Inside map, main thread: \(Thread.isMainThread)")
                Thread.sleep(forTimeInterval: 2)
                return generated*2
            }
            //Note receive must be under a computation otherwise,
            //the computation takes place in in the same thread as receive points to.
            .receive(on: DispatchQueue.main)
            .sink { generated in
                print("Inside sink, main thread: \(Thread.isMainThread)")
                self.content = "\(generated)"
            }
    }
}


class BlockingRandomStringViewModel: ObservableObject {
    var content: String = ""
    var cancellable: Cancellable?
    
    func regenerate() {
        cancellable = Just(Int.random(in: 1...100))
            .map { (generated: Int) in
                Thread.sleep(forTimeInterval: 2)
                return generated*2
            }
            .sink { generated in
                self.content = "\(generated)"
                self.objectWillChange.send()
            }
    }
}

struct BlockingRandomStringView: View {
    
    @ObservedObject private var viewModel = BlockingRandomStringViewModel()
    
    var body: some View {
        VStack {
            Text("Content: \(viewModel.content)")
            Button("Regenerate content - blocking") {
                viewModel.regenerate()
            }
        }.background(.yellow)
    }
}

struct NonBlockingRandomStringView: View {
    
    @ObservedObject private var viewModel = NonBlockingRandomStringViewModel()
    
    var body: some View {
        VStack {
            Text("Content: \(viewModel.content)")
            Button("Regenerate content - non blocking") {
                viewModel.regenerate()
            }
        }.background(.green)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            BlockingRandomStringView()
            NonBlockingRandomStringView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
