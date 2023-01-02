//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

//https://www.swiftbysundell.com/tips/property-wrapper-default-values/

@propertyWrapper struct Capitalized {
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.capitalized }
    }
    
    //initializer has to have format as below
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}

struct ContentView: View {

    @State @Capitalized var text = "hello world"
    var body: some View {
        Text(text)
        Button("Change text") {
            text = "hello universe"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
