//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    init() {
        let search = /My name is (?<name>.+?) and I'm (?<age>\d+) years old./
        let greeting = "My name is Taylor and I'm 26 years old."
        if let result = try? search.wholeMatch(in: greeting) {
            print("Name: \(result.name)")
            print("Age: \(result.age)")
        }
    }
    
    var body: some View {
        
        VStack {
            Text("I like bats".replacing(/[a-d]ats/, with: "dogs"))
            Text("I like cats".replacing(/[a-d]ats/, with: "dogs"))
            Text("I like rats".replacing(/[a-d]ats/, with: "dogs"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
