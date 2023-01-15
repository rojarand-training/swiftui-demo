//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

class MutableModel {
    var name = ""
}

actor ActorViewModel: ObservableObject {
    private var model = MutableModel()
    func do1() {
        model.name = "Foo"
    }
    
    func do2() {
        model.name = "Bar"
    }
}

final class ClassViewModel: ObservableObject, Sendable {
    private let model = MutableModel()
    
    func do1() {
        model.name = "Foo"
    }
    func do2() {
        model.name = "Bar"
    }
}

struct ContentView: View {
    @ObservedObject var classViewModel = ClassViewModel()
    @ObservedObject var actorViewModel = ActorViewModel()
    var body: some View {
        VStack {
            Button("do smth") {
                Task {
                    classViewModel.do1()
                }
                Task {
                    classViewModel.do2()
                }
                
                Task {
                    await actorViewModel.do1()
                }
                Task {
                    await actorViewModel.do2()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
