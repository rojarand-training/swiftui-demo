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
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(1..<20) { i in
                    VStack {
                        GeometryReader { geo in
                            Text("Item: \(i)")
                                .font(.largeTitle)
                                .padding()
                                .background(.red)
                                
                                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).minX) / 8), axis: (x: 0, y: 1, z: 0))
                                .frame(width: 200, height: 200)
                        }.frame(width: 200, height: 200)
                    }
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
