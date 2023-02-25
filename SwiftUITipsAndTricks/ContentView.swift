//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine


final class ContentViewModel: ObservableObject {
    @Published var throttleValue: Int = 0
    @Published var debounceValue: Int = 0
    
    private let throttleSubject = PassthroughSubject<Int, Error>()
    private let debounceSubject = PassthroughSubject<Int, Error>()
    private var cancellables: Set<AnyCancellable> = []
    init() {
        //1000ms
        throttleSubject
            .throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink { _ in
            } receiveValue: { value in
                self.throttleValue = value
            }.store(in: &cancellables)
        
        debounceSubject
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { value in
                NSLog("Debounce receive: \(value)")
                self.debounceValue = value
            }.store(in: &cancellables)
    }
    
    func runThrottling() {
        Task {
            var index = 0
            let stream = AsyncThrowingStream<Int,Error> {
                guard index < 10 else { return nil }
                index += 1
                try await Task.sleep(nanoseconds: 450_000_000)//450ms
                return index
            }
            for try await i in stream {
                throttleSubject.send(i)
            }
        }
    }
    
    func runDebouncing() {
        Task {
            var index = 0
            //2 will be received, because next will be send after 600 ms
            let delays = [(1, 200), (2, 200), (3, 600), (4, 200), (5,200), (6,200), (7,200)]
            let stream = AsyncThrowingStream<Int,Error> {
                guard index < delays.count else { return nil }
                let delay = delays[index]
                index += 1
                
                NSLog("Will send: \(delay.0), after: \(delay.1) ms")
                try await Task.sleep(nanoseconds: UInt64(delay.1*1_000_000))//450ms
                return delay.0
            }
            
            for try await i in stream {
                NSLog("Debounce send: \(i)")
                debounceSubject.send(i)
            }
        }
    }
}

struct ContentView: View {

    @ObservedObject private var vm = ContentViewModel()
    
    var body: some View {
        VStack {
            VStack {
                Text("Throttle emits value with constant delay")
                Text("Throttle value: \(vm.throttleValue)")
                Button("Run throttling") {
                    vm.runThrottling()
                }
            }
            .padding()
            .background(.yellow)
            
            VStack {
                Text("Debounce waits until there is nothing received, then emits LAST element")
                Text("Debounce value: \(vm.debounceValue)")
                Button("Run debounce") {
                    vm.runDebouncing()
                }
            }
            .padding()
            .background(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
