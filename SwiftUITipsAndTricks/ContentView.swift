//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var enableBlueButtonRoundedCorners = false
    @State var enableRedButtonRoundedCorners = false
    @State var textHidden = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                
                withAnimation(.easeIn(duration: 3)) {
                    enableBlueButtonRoundedCorners.toggle()
                }
            } label: {
                Text("Hello")
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(enableBlueButtonRoundedCorners ? 30 : 0)
            }
            
            Button {
                /*
                 NOTE!!! Because 'toggling' is outside of the animation block,
                 it does not respect duration
                */
                enableRedButtonRoundedCorners.toggle()
                
                withAnimation(.easeIn(duration: 3)) {
                }
            } label: {
                Text("Hello")
                    .padding()
                    .foregroundColor(.white)
                    .background(.red)
                    .cornerRadius(enableRedButtonRoundedCorners ? 30 : 0)
            }
            VStack {
                Button(textHidden ? "Show text" : "Hide text") {
                    textHidden.toggle()
                }
                DisappearingText(disappear: $textHidden)
            }
        }
    }
}

struct DisappearingText: View {
    
    var disappear: Binding<Bool>
    
    var body: some View {
        
        Text("I'm disappearing text")
            .opacity(disappear.wrappedValue ? 0.0 : 1.0)
            .animation(.easeIn(duration: 2.0), value: disappear.wrappedValue)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
