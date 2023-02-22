//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

final class Chat: ObservableObject {
    
    @Published var state: String = ""
    @Published var message: String = ""
   
    private var subject: any Subject<String, Error>
    private var cancellable: AnyCancellable?
    
    init(subject: any Subject<String, Error>) {
        self.subject = subject
        cancellable = subject.sink { completion in
            switch completion {
            case .failure(let error):
                self.state = "Error: \(error.localizedDescription)"
            case .finished:
                self.state = "Finished"
            }
        } receiveValue: { message in
            self.message = message
        }
    }
    
    func close() {
        subject.send(completion: .finished)
    }
    
    func sendRandomMessage() {
        let randomValue = Int.random(in: 1...1000)
        subject.send("Message no: \(randomValue)")
    }
    
    func simulateError() {
        subject.send(completion: .failure(URLError(.badURL)))
    }
}

struct PassthroughContentView: View {

    @ObservedObject private var chatViewModel: Chat
    
    init(subject: any Subject<String, Error>) {
        self.chatViewModel = Chat(subject: subject)
    }
    var body: some View {
        VStack {
            HStack {
                Text("State: ").bold()
                Text(chatViewModel.state)
                Spacer()
            }.padding()
            
            HStack {
                Text("Message: ").bold()
                Text(chatViewModel.message)
                Spacer()
            }.padding()
            
            Button("Send random message") {
                chatViewModel.sendRandomMessage()
            }
            Button("Simulate error") {
                chatViewModel.simulateError()
            }
            Button("Close") {
                chatViewModel.close()
            }
        }
    }
}

struct ContentView: View {
    @State var resetCounter: Int = 0
    var body: some View {
        VStack {
            Text("Reset count: \(resetCounter)")
            IncrementCounterView(counter: $resetCounter)
            Text("PassthroughSubject example")
                .bold()
                .padding()
                .background(.yellow)
            PassthroughContentView(subject: PassthroughSubject())
                .background(.yellow)
            Text("CurrentValueSubject example")
                .bold()
                .padding()
                .background(.green)
            PassthroughContentView(subject: CurrentValueSubject("Initial message"))
                .background(.green)

        }
    }
}

struct IncrementCounterView: View {
    @Binding var counter: Int
    var body: some View {
        Button("Reset view") {
            counter += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
