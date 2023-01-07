//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct MeasurableView<Content: View>: View {
    
    private let title: String
    private let content: () -> Content
    
    init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                Text("\(title)\nWidth: \(reader.size.width), height: \(reader.size.height)")
                content()
            }
        }
    }
}

struct ContentView: View {
    
    var body: some View {
        VStack {
            MeasurableView("Root") {
                MeasurableView("Inner Top - nesting level 1") {
                    Text("Inner top text 1")
                    Text("Inner top text 2")
                    Text("Inner top text 3")
                    MeasurableView("Inside Inner Top - nesting level 2") {
                        Text("Inner top text 1")
                    }.padding()
                    .border(.blue, width: 5)
                    .background(.gray)
                }.background(.yellow)
                MeasurableView("Inner Bottom - nesting level 1") {
                    Text("Inner bottom text")
                }.background(.green)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
