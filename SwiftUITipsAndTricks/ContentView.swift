//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

@available(iOS 15, *)
struct ContentView: View {
    var body: some View {
        if #available(iOS 16, *) {
            Text("Hello, you are running iOS 16 or newer")
        } else {
            Text("Hello, you are running iOS 15 or older")
        }
        
        if #unavailable(iOS 16) {
            Text("Hello, you are running iOS 15 or older")
        } else {
            Text("Hello, you are running iOS 16 or newer")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
