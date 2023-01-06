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
    
    var body: some View {
        VStack {
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
