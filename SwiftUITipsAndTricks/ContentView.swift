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
            
            Circle()
                .fill(.red)
                .frame(width: 100)
            
            Rectangle()
                .fill(.green)
                .frame(width: 200, height: 100)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.orange)
                .frame(width: 200, height: 100)
            
            Capsule(style: .continuous)
                .fill(.blue)
                .frame(width: 200, height: 100)
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
