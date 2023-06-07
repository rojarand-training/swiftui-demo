//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

//theatermasks
//shareplay
//person.3.sequence.fill

struct ContentView: View {

    var body: some View {
        VStack {
            VStack {
                Text(".symbolRenderingMode(.hierarchical)")
                    .font(.system(size: 12))
                
                Image(systemName: "theatermasks")
                    .foregroundColor(.orange)
                    .symbolRenderingMode(.hierarchical)
                    .font(.system(size: 64))
            }.padding(10)
            
            VStack {
                Text(".symbolRenderingMode(.palette) & foregroundStyle(.orange, .green)")
                    .font(.system(size: 12))
                
                Image(systemName: "shareplay")
                    .foregroundStyle(.orange, .green)
                    .symbolRenderingMode(.palette)
                    .font(.system(size: 64))
            }.padding(10)
            
            VStack {
                Text(".symbolRenderingMode(.palette) & foregroundStyle(linearGradient)")
                    .font(.system(size: 12))
                
                Image(systemName: "person.3.sequence.fill")
                    .foregroundStyle(
                        .linearGradient(colors: [.red, .black], startPoint: .top, endPoint: .bottom),
                        
                        .linearGradient(colors: [.green, .yellow], startPoint: .top, endPoint: .bottomTrailing),
                        
                        .linearGradient(colors: [.blue, .brown], startPoint: .top, endPoint: .bottomTrailing)
                    )
                    .symbolRenderingMode(.palette)
                    .font(.system(size: 64))
            }.padding(10)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
