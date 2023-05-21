//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI

struct ContentView: View {

    @State var trimSize = 0.0
    private let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.5)
                    .fill(.blue)
                    .frame(width: 100, height: 100)
                Text("trim(from: 0.0, to: 0.5)")
            }
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.75)
                    .fill(.blue)
                    .frame(width: 100, height: 100)
                Text("trim(from: 0.0, to: 0.75)")
            }
            
            ZStack {
                Circle()
                    .trim(from: 0.25, to: 0.75)
                    .fill(.blue)
                    .frame(width: 100, height: 100)
                Text("trim(from: 0.25, to: 0.75)")
            }
                
            Rectangle()
                .trim(from: 0.0, to: trimSize)
                .stroke(.red, lineWidth: 20)
                .frame(width: 200, height: 200)
                .onReceive(timer) { _ in
                    withAnimation {
                        if trimSize >= 1.0 {
                            trimSize = 0.0
                        } else {
                            trimSize += 0.2
                        }
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
