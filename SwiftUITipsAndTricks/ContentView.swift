//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct BannerView: View {
    let message: String
    var show: Bool
    
    var body: some View {
        Text(message)
            .font(.title)
            .frame(width:UIScreen.main.bounds.width - 20,
                   height: 100)
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(10)
            .offset(y: show ?
                    UIScreen.main.bounds.height / 2.5 :
                        UIScreen.main.bounds.height)
    }
}

struct ContentView: View {
    @State
    var show = false
    
    var body: some View {
        VStack {
            BannerView(message: "Hello, World!", show: show)
            Button {
                withAnimation(.easeOut(duration: 1.2)) {
                    show.toggle()
                    if show {
                        Task {
                            try? await Task.sleep(nanoseconds: 3_000_000_000)
                            show.toggle()
                        }
                    }
                }
            } label: {
                Text(show ? "Hide" : "Show")
                    .padding()
                    .frame(width: 100)
                    .foregroundColor(.white)
                    .background(show ? .red : .blue)
                    .cornerRadius(10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
