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
        NavigationStack {
            List {
                ForEach(1..<20) { index in
                    Text("Row: \(index)")
                }
            }
            .navigationTitle("Select a row")
            .safeAreaInset(edge: .bottom) {
                Text("Hello I'am the very bottom view")
                    .frame(maxWidth: .infinity)
                    .background(.yellow)
            }
            .safeAreaInset(edge: .bottom, alignment: .trailing) {
                Button {
                    print("Help tapped")
                } label: {
                    Image(systemName: "info.circle.fill")
                        .font(.largeTitle)
                        .symbolRenderingMode(.multicolor)
                        .padding(.trailing)
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
