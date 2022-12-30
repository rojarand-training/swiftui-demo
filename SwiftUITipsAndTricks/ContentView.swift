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
        VStack(spacing: 10) {
            Text("Hello")
                .background(.white)
            Spacer()
                .frame(height: 25)
            Text("World 1")
                .background(.yellow)
            Text("World 2")
                .background(.yellow)
        }.background(.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
