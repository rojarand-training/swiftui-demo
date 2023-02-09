//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct BackgroundColorPreferenceKey: PreferenceKey {
    static var defaultValue: Color { .clear }
    static func reduce(value: inout Self.Value, nextValue: () -> Self.Value) {
        value = nextValue()
    }
}

struct BackgroundView<Content: View>: View {

    @State var bgColor = BackgroundColorPreferenceKey.defaultValue
    let content: () -> Content
    init(content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
            .background(bgColor)
            .onPreferenceChange(BackgroundColorPreferenceKey.self) { color in
                bgColor = color
            }
    }
}

struct ContentView: View {
    
    //NOTE!!! Assinging `defaultValue` causes strange compilation error: "Generic parameter 'Content' could not be inferred"
    //@State var color: Color = BackgroundColorPreferenceKey.defaultValue
    @State var color: Color = .clear
    var body: some View {
        BackgroundView {
            VStack {
                Button("Make bg green") {
                    color = .green
                }
                Button("Make bg red") {
                    color = .red
                }
            }.preference(key: BackgroundColorPreferenceKey.self, value: color)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
