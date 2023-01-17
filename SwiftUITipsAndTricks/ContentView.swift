//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct V1: View{
    
    var body: some View {
        Text("V1")
            .background(.red)
            .padding()
            .border(.blue)
    }
}

struct V2: View{
    
    var body: some View {
        Text("V2")
            .background(.red)
            .border(.blue)
            .padding()
    }
}

struct ContentView: View {
    
    var body: some View {
        VStack {
            v1()
            v2()
        }
    }
    
    private func v1() -> some View {
        let v = V1()
        print(type(of: v.body))
        return v
    }
    
    private func v2() -> some View {
        let v = V2()
        print(type(of: v.body))
        return v
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
