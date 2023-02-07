//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

extension Button where Label==Image {
    init(imageSystemName: String, action: @escaping () -> Void) {
        self.init(action: action, label: {
            Image(systemName: imageSystemName)
        })
    }
}

struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("Hello World")
            
            //Normal way
            Button {
                print("Hello")
            } label: {
                Image(systemName: "folder.fill.badge.plus")
            }
            
            //Improved way
            Button(imageSystemName:"folder.fill.badge.plus") {
                print("Hello")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
