//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

class ContentViewModel: ObservableObject {
   
    @Published var event: String = ""
    
    func fireTask() {
        Task {
            await updateLog("Main thread? : \(Thread.isMainThread ? "YES" : "NO") ")
        }
    }
    
    @MainActor private func updateLog(_ event: String) {
        self.event = event
    }
}

struct ContentView: View {

    @ObservedObject private var viewModel = ContentViewModel()
    @State private var event: String = ""
    
    var body: some View {
        Text("From the task declared in the view: \(event)")
        Button("Fire view.task") {
            Task {
                event = "Main thread? : \(Thread.isMainThread ? "YES" : "NO") "
            }
        }
        
        Text("From the task declared in the view: \(viewModel.event)")
        Button("Fire viewModel.task") {
            viewModel.fireTask()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
