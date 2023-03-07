//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State private var allOptions: Int = 0
    
    var body: some View {
        VStack {
            Text("Active options: \(allOptions)")
            
            HStack {
                Text("'switch' style:")
                Toggle("Option 1", isOn: Binding(get: {
                    (allOptions & 0b00000001 == 0b00000001)
                }, set: { isOn, _ in
                    if isOn {
                        allOptions |= 0b00000001
                    } else {
                        allOptions &= ~(0b00000001)
                    }
                })).toggleStyle(.switch)
            }.padding()
            
            HStack {
                Text("'button' style:")
                Toggle("Option 2", isOn: Binding(get: {
                    (allOptions & 0b00000010 == 0b00000010)
                }, set: { isOn, _ in
                    if isOn {
                        allOptions |= 0b00000010
                    } else {
                        allOptions &= ~(0b00000010)
                    }
                })).toggleStyle(.button)
            }.padding()
            
            HStack {
                Text("'automatic' style:")
                Toggle("Option 3", isOn: Binding(get: {
                    (allOptions & 0b00000010 == 0b00000010)
                }, set: { isOn, _ in
                    if isOn {
                        allOptions |= 0b00000010
                    } else {
                        allOptions &= ~(0b00000010)
                    }
                })).toggleStyle(.automatic)
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
