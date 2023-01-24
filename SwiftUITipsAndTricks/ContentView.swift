//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State private var sliderValue: Double = 0
    var body: some View {
        VStack {
            Slider(value: $sliderValue, in: 0...100)
            Text("Current value: \(sliderValue)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
