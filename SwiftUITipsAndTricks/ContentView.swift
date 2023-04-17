//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    private let stringIsNotMarkdown: String = "I'm plain string so not a **markdown** *string*."
    private let localizedStringIsMarkdown: LocalizedStringKey = "I'm **localized string**."
    
    var body: some View {
        VStack {
            
            Text("I'm a **markdown** *string*. [Google](www.google.com)")
            Text(verbatim: "I'm not a **markdown** *string*.")
            Text(stringIsNotMarkdown)
            Text(localizedStringIsMarkdown)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
