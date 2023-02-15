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
            VStack {
                Text(".xxxLarge - font default")
                Text(".xxxLarge - font title")
                    .font(.title)
            }.environment(\.dynamicTypeSize, .xxxLarge)
            VStack {
                Text(".small - font default")
                Text(".small - font title")
                    .font(.title)
            }.environment(\.dynamicTypeSize, .small)
                .background(.gray)
            VStack {
                Text(".accessibility1 - font default")
                Text(".accessibility1 - font title")
                    .font(.title)
            }.environment(\.dynamicTypeSize, .accessibility1)

            VStack {
                Text(".accessibility5 - font default")
                Text(".accessibility5 - font title")
                    .font(.title)
            }.environment(\.dynamicTypeSize, .accessibility5)
                .background(.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
