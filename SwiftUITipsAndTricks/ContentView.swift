//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

//Hash is recomputed every time app is launched

struct P: Hashable {
    let x: Float
    let y: Float
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

struct InnerContentView: View {
    
    var body: some View {
        VStack {
            Text("Date: \(Date().timeIntervalSince1970)")
            Text("Hash of Int(5): \(5.hashValue)")
            Text("Hash of Int(0): \(0.hashValue)")
            Text("Hash of P(2.0, 3.0): \(P(x: 2.0, y: 3.0).hashValue)")
            Text("Hash of P(2.0, 3.0): \(P(x: 2.0, y: 3.0).hashValue)")
            Text("Hash of P(0.0, 0.0): \(P(x: 0.0, y: 0.0).hashValue)")
        }
    }
}


struct ContentView: View {
    
    @State private var rerun = true
    
    var body: some View {
        VStack {
            if rerun {
                InnerContentView()
            } else {
                InnerContentView()
            }
            Button("Rerun") {
                rerun.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
