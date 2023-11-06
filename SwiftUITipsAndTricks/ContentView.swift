//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

final class ContentViewModel: ObservableObject {
    
    @Published var result: String = ""
    @Published var status: String = ""
    
    private var workItem: DispatchWorkItem?
    
    func run() {
        workItem?.cancel()
        let newWorkItem = DispatchWorkItem() { [weak self] in
            self?.result = "Success"
        }
        newWorkItem.notify(queue: .main) { [weak self] in
            self?.status = newWorkItem.isCancelled ? "CANCELLED" : "FINISHED"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: newWorkItem)
        workItem = newWorkItem
    }
}

struct ContentView: View {

    @StateObject private var vm = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Finished ?: \(vm.status)")
            Text("Current result: \(vm.result)")
            Button("Execute Action") {
                vm.run()
            }
            .foregroundColor(.white)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.blue))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
