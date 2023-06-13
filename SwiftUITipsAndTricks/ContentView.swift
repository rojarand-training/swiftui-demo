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
            HStack {
                Text("This is a short text 1")
                    .padding()
                    .background(.green)
                    .foregroundColor(.white)
                Text("This is a very very very very  very very long string 1")
                    .padding()
                    .background(.red)
                    .foregroundColor(.white)
            }
            .fixedSize(horizontal: false, vertical: true)
            //.frame(maxHeight: 100)
            
            HStack {
                Text("This is a short string 2")
                    .padding()
                    .background(.green)
                    .foregroundColor(.white)
                Text("This is a very very very very  very very long string 2")
                    .padding()
                    .background(.red)
                    .foregroundColor(.white)
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxHeight: 100)
            
            VStack {
                Button("Sign in") {}
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                Button("Create a new account") {}
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            .fixedSize(horizontal: true, vertical: false)
            
            VStack {
                Button("Log in") { }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .clipShape(Capsule())

                Button("Reset Password") { }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .clipShape(Capsule())
            }
            .fixedSize(horizontal: true, vertical: false)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
