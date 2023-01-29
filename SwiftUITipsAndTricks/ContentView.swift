//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

@propertyWrapper struct PersistentCounter {
    var wrappedValue: Int {
        nonmutating set {
            print("Setting newValue: \(newValue)")
            UserDefaults().set(newValue, forKey: Self.keyName)
            UserDefaults().synchronize()
        }
        
        get {
            let value = UserDefaults().integer(forKey: Self.keyName)
            print("Getting value: \(value)")
            return value
        }
    }
    
    init(wrappedValue: Int) {
        self.wrappedValue = wrappedValue
    }
    
    init() {
        let initValue = UserDefaults().integer(forKey: Self.keyName)
        print("InitValue: \(initValue)")
        self.init(wrappedValue: initValue)
    }
    
    private static var keyName = "COUNTERX"
}

struct ContentView: View {
    @State var title = "hello world"
    @PersistentCounter var counter
    var body: some View {
        VStack {
            Button("Change Title") {
                counter = counter + 1//reassingning
                title = "hello world, times: \(counter)"
            }
            Text("Title: \(title)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
