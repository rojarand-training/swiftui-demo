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
        VStack {
            Text("Hello World")
            Button {
                
            } label: {
                Text("Add to cart")
            }
            Button {
                
            } label: {
                Text("Remove from cart")
            }
            Button {
                
            } label: {
                Text("Go to cart")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
