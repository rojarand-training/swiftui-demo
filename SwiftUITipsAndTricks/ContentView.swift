//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State var numbers = [1,2,3,4]
    @State var names = ["Robert", "Maria", "Bartosz", "Hanna"]
    let length = Measurement(value: 186, unit: UnitLength.centimeters)
    
    var body: some View {
        VStack {
            HStack {
                Text(numbers, format: .list(memberStyle: .number, type: .and))
                Button("Add number") {
                    numbers.append(numbers.count+1)
                }
            }
            Text(names, format: .list(type: .and))
            Text(length, format: .measurement(width: .wide))
            Text(length, format: .measurement(width: .abbreviated))
            Text(length, format: .measurement(width: .narrow))
            Text(120, format: .currency(code: "PLN"))
            Text(120, format: .currency(code: "USD"))
            Text(120, format: .currency(code: "CAD"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
