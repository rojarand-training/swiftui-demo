//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State private var selection = 1
    
    var body: some View {
        
        TabView(selection: $selection) {
            Text("Tab1")
                .zoomInOnAppear()
                .tag(0)
            
            Text("Tab2")
                .zoomInOnAppear()
                .tag(1)
            
            Text("Tab3")
                .zoomInOnAppear()
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

extension View {
    func zoomInOnAppear() -> some View {
        self.modifier(ZoomIn())
    }
}

struct ZoomIn: ViewModifier {
    @State var isAnimating = false
    func body(content: Content) -> some View {
        content
            .scaleEffect(isAnimating ? 3.0 : 0.9)
            .onAppear {
            isAnimating = false
            withAnimation(.easeOut(duration: 1.2)) {
                isAnimating = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
