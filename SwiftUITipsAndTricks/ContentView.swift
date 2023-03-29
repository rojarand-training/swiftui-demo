//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

func drawMagicNumber() -> Int {
    Int.random(in: 1...100)
}

protocol MagicNumberObserver {
    func onMagicNumber(_ number: Int)
}

struct MagicNumberLogger: MagicNumberObserver {
    
    func onMagicNumber(_ number: Int) {
        NSLog("Magic number: \(number)")
    }
}

struct LeakyMagicNumberGenerator {
    
    private var observers = [MagicNumberObserver]()
    
    func generate() {
        let number = drawMagicNumber()
        notifyNumberChanged(number)
    }
    
    mutating func addObserver(_ observer: MagicNumberObserver) {
        observers.append(observer)
    }
    
    private func notifyNumberChanged(_ number: Int) {
        observers.forEach { observer in
            observer.onMagicNumber(number)
        }
    }
}

struct Weak<Object> {
    var object: Object? {
        provider()
    }
    
    private let provider: () -> Object?
    
    init(_ object: Object) {
        let reference = object as AnyObject
        provider = { [weak reference] in
            reference as? Object
        }
    }
}

struct NonLeakyMagicNumberGenerator {
    
    private var observers = [Weak<MagicNumberObserver>]()
    
    func generate() {
        let number = drawMagicNumber()
        notifyNumberChanged(number)
    }
    
    mutating func addObserver(_ observer: MagicNumberObserver) {
        observers.append(Weak(observer))
    }
    
    private func notifyNumberChanged(_ number: Int) {
        observers.forEach { weakObserver in
            let isNil = (weakObserver.object != nil) ? "non nil" : "NIL"
            NSLog("Observer: \(isNil)")
            weakObserver.object?.onMagicNumber(number)
        }
    }
}



final class MagicContentViewModel: ObservableObject, MagicNumberObserver {
    
    @Published private (set) var number: Int = 0
    private var generator = NonLeakyMagicNumberGenerator()
//    private var generator = LeakyMagicNumberGenerator()
    
    private var logger = MagicNumberLogger()
    
    init() {
        generator.addObserver(self)
        generator.addObserver(logger)
    }
    
    deinit {
        print("MagicContentViewModel deinit")
    }
    
    func reset() {
        
    }
    
    func generate() {
        generator.generate()
    }
    
    func onMagicNumber(_ number: Int) {
        self.number = number
    }
}


struct MagicContentView: View {
    @ObservedObject private var vm = MagicContentViewModel()
    
    var body: some View {
        VStack {
            Text("Magic number: \(vm.number)")
            Button("Generate magic number") {
                vm.generate()
            }
            Button("Reset") {
                vm.reset()
            }
        }
    }
}

struct ContentView: View {
    
    @State private var isShown = false
    var body: some View {
        
        VStack {
            Toggle("Show magic content", isOn: $isShown)
            if isShown {
                MagicContentView()
            } else {
                Text("Magic content is hidden")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
