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
        PersonalInfoView()
            .environment(\.redactionReasons, .privacy)
    }
}

struct PersonalInfoView: View {
    
    @Environment(\.redactionReasons) var redactionReasons
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text("Sex orientation: ")
                Text("Gay")
                    .privacySensitive()
            }
            HStack {
                Text("Card number: ")
                Text("1234-4567-8901-2345-6789")
                    .privacySensitive()
            }
            HStack {
                Text("ID: ")
                if redactionReasons.contains(.privacy) {
                    Text("[HIDDEN]")
                } else {
                    Text("CDA 98765432")
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
