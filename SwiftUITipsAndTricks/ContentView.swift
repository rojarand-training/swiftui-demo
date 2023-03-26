//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct FullName {
    let value: String
}

extension FullName: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.value = value.capitalized
    }
}

extension FullName: ExpressibleByNilLiteral {
    init(nilLiteral: ()) {
        self.value = "Unknown name"
    }
}

extension FullName {
    func callAsFunction() -> String {
        self.value
    }
}

struct ContentView: View {

    let initializedFullName: FullName = "robert andrzejczyk"
    let emptyFullName: FullName = nil
    
    var body: some View {
        VStack {
            Text("Hello: \(initializedFullName())")
            Text("Hello: \(emptyFullName())")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
