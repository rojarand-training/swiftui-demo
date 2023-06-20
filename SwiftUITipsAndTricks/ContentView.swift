//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData


struct ContentView: View {
    
    var body: some View {
        ViewThatFits {
            Label("Welcome to AwsomeApp hahaahaha", systemImage: "bolt.shield")
                .font(.largeTitle)
            
            Label("Hello again", systemImage: "bolt.shield")
                .font(.largeTitle)
            
            Label("Hello", systemImage: "bolt.shield")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
