//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct Model {
    var name: String
    init(name: String) {
        self.name = name
    }
}

actor ContentViewModel3: ObservableObject {
    
    var model = Model(name: "")
    
    nonisolated func nonIsolatedCalc() async {
        print("||| nonIsolatedCalc - Begin, access to internal props is granted when isolated methods are ended")
        let _ = await model.name
        print("||| nonIsolatedCalc - End")
    }
    
    func isolatedCalc() {
        print("---- Begin of isolatedCalc - Main Thread: \(Thread.isMainThread ? "Yes": "No")")
        innerIsolatedCalc()
        print("---- End of isolatedCalc - Main Thread: \(Thread.isMainThread ? "Yes": "No")")
    }
    
    private func innerIsolatedCalc() {
        print("--------- Hello from innerIsolatedCalc - Main Thread: \(Thread.isMainThread ? "Yes": "No")")
        Thread.sleep(forTimeInterval: 2)
    }
    
    func isolatedAsyncCalc() async {

        print("---- Begin of isolatedAsyncCalc, access to internal props is granted without awaiting because we are in safe context now")
        let _ = model.name
        print("---- End of isolatedAsyncCalc")
    }
}

struct ContentView: View {
    @ObservedObject var vm1 = ContentViewModel3()
    
    var body: some View {
        VStack {
            Text("Hello World")
            Button("Isolated calc") {
                Task {
                    await vm1.isolatedCalc()
                }
            }
            .padding()
            Button("Isolated async calc") {
                Task {
                    await vm1.isolatedAsyncCalc()
                }
            }
            .padding()
            Button("Non isolated calc") {
                Task {
                    await vm1.nonIsolatedCalc()
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
