//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State var variableValue = 0.5
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "aqi.low", variableValue: variableValue)
                Image(systemName: "wifi", variableValue: variableValue)
                Image(systemName: "chart.bar.fill", variableValue: variableValue)
                Image(systemName: "waveform", variableValue: variableValue)
                
            }
            .foregroundColor(.red)
            Slider(value: $variableValue)
                .padding(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
