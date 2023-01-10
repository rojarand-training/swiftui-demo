//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

var eventsLog = ""

@MainActor class CounterViewModel: ObservableObject {
    @Published var counter = 0
    private var task: Task<(), Error>?
    deinit {
        eventsLog += "CounterView deinit\n"
    }
    
    func sleepFor1Seconds() async throws {
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
        } catch {
            eventsLog += "--->>> Task.sleep exception caught\n"
            throw error
        }
    }
    
    func increment() {
        task = Task {
            try await sleepFor1Seconds()
            counter += 1
        }
    }
    
    func cancel() {
        task?.cancel()
        task = nil
    }
}

@MainActor struct CounterView: View {
    @ObservedObject private var viewModel = CounterViewModel()
    var body: some View {
        VStack {
            Text("CounterView")
            Button("Wait and Increment") {
                viewModel.increment()
            }
            Text("Value: \(viewModel.counter)")
        }.onDisappear {
            eventsLog += "CounterView onDisappear\n"
            eventsLog += "Will cancel task execution\n"
            viewModel.cancel()
        }.background(.yellow)
    }
}

class ContentViewModel: ObservableObject {
    @Published var showCounterView = true
}

struct ContentView: View {

    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            if viewModel.showCounterView {
                CounterView()
            }
            Button(viewModel.showCounterView ? "Destroy Counter" : "Show Counter") {
                viewModel.showCounterView.toggle()
            }
            Text(eventsLog)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
