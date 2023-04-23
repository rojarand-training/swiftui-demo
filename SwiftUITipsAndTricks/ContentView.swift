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
        VStack {
            Text("Hello World")
                .font(.system(size: 50))
                .foregroundColor(.green)
                .padding(20)
                .background(
                    Circle()
                        .fill(.red)
                        .frame(width: 150, height: 150)
                )
            
            Spacer()
                .frame(height: 50)
            
            /*
             By default background views automatically take up as much space as they need to be fully visible, but if you want you can have them be clipped to the size of their parent view using the clipped()
            */
            Text("Hello World")
                .font(.system(size: 50))
                .foregroundColor(.green)
                .padding(20)
                .background(
                    Circle()
                        .fill(.red)
                        .frame(width: 150, height: 150)
                )
                .clipped()
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
