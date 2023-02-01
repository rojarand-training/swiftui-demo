//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var isAlertPresented = false
    
    var body: some View {
        VStack {
            VStack {
                Text("Appearance sample")
                Button("Destructive", role: .destructive) {
                    
                }
                Button("Cancel", role: .cancel) {
                    
                }
                Button("Default") {
                    
                }
            }.border(.gray)
            
            VStack {
                Text("Alert sample")
                Button("Show alert") {
                    isAlertPresented = true
                }
                .alert("Alert", isPresented: $isAlertPresented) {
                    Button("Destructive", role: .destructive) {}
                    Button("Cancel", role: .cancel) {}
                    Button("Default") {}
                }
            }.border(.gray)
            
            List((0..<5)) { value in
                Text("\(value)")
                    .swipeActions {
                        Button("Destructive", role: .destructive) {}
                        Button("Cancel", role: .cancel) {}
                        Button("Default") {}
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
