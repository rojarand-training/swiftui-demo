//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct CustomBackgroundColor: EnvironmentKey {
    static var defaultValue: Color = .red
}

extension EnvironmentValues {
    var cbc: Color {
        get { self[CustomBackgroundColor.self] }
        set { self[CustomBackgroundColor.self] = newValue }
    }
}

struct ContentView: View {

    var body: some View {
        VStack {
            Parent(text: "No bg color defined")
            Parent(text: "Bg color defined")
                .environment(\.cbc, .blue)
        }
    }
}

struct Child: View {
    @Environment(\.cbc) var customColor: Color
    
    var body: some View {
        Text("I'm a child view")
            .background(customColor)
    }
}

struct Parent: View {
    let text: String
    var body: some View {
        HStack {
            Text(text)
            Child()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
