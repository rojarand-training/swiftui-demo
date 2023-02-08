//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let colors: [Color] = [.yellow, .red, .blue, .brown]
    
    var body: some View {
        VStack {
            HStack {
                Text("Hello").bold().foregroundColor(.blue)
                Text("World").italic().foregroundColor(.red)
            }
            Text("Hello").bold().foregroundColor(.blue) +
            Text("World").italic().foregroundColor(.red)
           
            colors.reduce(Text("")) { partialResult, color in
                partialResult + Text("Hello").foregroundColor(color)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
