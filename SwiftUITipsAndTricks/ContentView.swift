//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

class ClassComputer {
    
    var currentValue = 0
    
    func double() -> Int {
        print("--- Class/Before double, main thread: \(Thread.isMainThread)")
        Thread.sleep(forTimeInterval: 2)
        currentValue *= 2
        print("Class/After double, main thread: \(Thread.isMainThread)")
        return currentValue
    }
    
    func randomize() -> Int {
        print("--- Class/Before randomize, main thread: \(Thread.isMainThread)")
        Thread.sleep(forTimeInterval: 2)
        currentValue = Int.random(in: 1...1000)
        print("Class/After randomize, main thread: \(Thread.isMainThread)")
        return currentValue
    }
}

actor ActorComputer {
    
    var currentValue = 0
    
    /*
     //Compilation error:
     //Actor-isolated property 'currentValue' can not be mutated from a non-isolated context
    nonisolated func square() -> Int {
        currentValue *= currentValue
        return currentValue
    }
     */
    
    func double() -> Int {
        print("--- Actor/Before double, main thread: \(Thread.isMainThread)")
        Thread.sleep(forTimeInterval: 2)
        currentValue *= 2
        print("Actor/After double, main thread: \(Thread.isMainThread)")
        return currentValue
    }
    
    func randomize() -> Int {
        print("--- Actor/Before randomize, main thread: \(Thread.isMainThread)")
        Thread.sleep(forTimeInterval: 2)
        currentValue = Int.random(in: 1...1000)
        print("After randomize, main thread: \(Thread.isMainThread)")
        return currentValue
    }
}

class ContentViewModel: ObservableObject {
    
    @Published var classValue: Int = 0
    @Published var actorValue: Int = 0
    
    private let classComputer = ClassComputer()
    func classRandomize() {
        Task.detached {
            let value = self.classComputer.randomize()
            await self.updateClassValue(newValue: value)
        }
    }
    
    func classDouble() {
        Task.detached {
            let value = self.classComputer.double()
            await self.updateClassValue(newValue: value)
        }
    }
    
    @MainActor private func updateClassValue(newValue: Int) {
        self.classValue = newValue
    }
    
    private let actorComputer = ActorComputer()
    func actorRandomize() {
        Task.detached {
            //Note actor do not use main thread any more
            let value = await self.actorComputer.randomize()
            await self.updateActorValue(newValue: value)
        }
    }
    
    func actorDouble() {
        Task.detached {
            let value = await self.actorComputer.double()
            await self.updateActorValue(newValue: value)
        }
    }
    
    @MainActor private func updateActorValue(newValue: Int) {
        self.actorValue = newValue
    }
}

//TODO: print thread

struct ContentView: View {
    
    @State var value: Int = 0
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        Spacer()
        VStack {
            Text("Current class value: \(viewModel.classValue)")
            Button("Class - Randomize value") {
                viewModel.classRandomize()
            }.padding()
            Button("Class - Double value") {
                viewModel.classDouble()
            }.padding()
        }.background(.gray)

        VStack {
            Text("Current actor value: \(viewModel.actorValue)")
            Button("Actor - Randomize value") {
                viewModel.actorRandomize()
            }.padding()
            Button("Actor - Double value") {
                viewModel.actorDouble()
            }.padding()
        }.background(.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
