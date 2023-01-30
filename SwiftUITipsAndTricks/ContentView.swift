//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

let name = "Robert"
let multilineString = """
    Hello \(name)
            - "\(name)" is a cool name
        I hope you are ok today.
        - Good bye \(name)
    """

struct ContentView: View {

    var body: some View {
        Text(multilineString)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
