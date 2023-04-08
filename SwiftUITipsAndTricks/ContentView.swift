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
   
    @State var textAlignment: TextAlignment = .trailing
    
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
            
            Picker("Text aligment", selection: $textAlignment) {
                ForEach(TextAlignment.allCases, id: \.self) { aligement in
                    Text(String(describing: aligement))
                }
            }
            
            Text("Extremely text line 1\nExtremely long text line 2\nExtremely long text line 3 .....\n")
                .lineSpacing(30)
                .fontDesign(.serif)
                .multilineTextAlignment(textAlignment)
            
            Text("Condensed font width")
                .fontWidth(.condensed)
            
            Text("Compressed font width")
                .fontWidth(.compressed)
            
            Text("Expanded font width")
                .fontWidth(.expanded)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
