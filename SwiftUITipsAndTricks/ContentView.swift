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
        VStack(spacing: 10) {
            Text("[Visit Apple](https://apple.com)")
            Link("Visit Apple", destination: URL(string: "https://apple.com")!)
        }.environment(\.openURL, OpenURLAction(handler: handleURL))
    }
    
    func handleURL(_ url: URL) -> OpenURLAction.Result {
        NSLog("URL to handle: \(url)")
        return .handled
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
