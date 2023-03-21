//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State var dark = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Text")
                    .foregroundColor(dark ? .white : .black)
                    .background(dark ? .black : .white)
                Button("Change text color") {
                    withAnimation(.easeIn(duration: 0.5)) {
                        dark.toggle()
                    }
                }
                
                NavigationLink("Show UIKit example", destination: {
                    UIKitAnimation()
                })
                .padding()
            }
        }
    }
}

struct UIKitAnimation: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        AnimationViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
