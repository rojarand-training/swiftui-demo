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
        ZStack {
            Color(.red)
                .ignoresSafeArea()
            Text("Hello World")
                    .padding(.top, 30)
                    .padding(.leading, 50)
                    .background(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
