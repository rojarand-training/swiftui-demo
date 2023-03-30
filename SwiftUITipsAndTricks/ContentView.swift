//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

extension View {
 
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
 
}

final class ContentViewModel: ObservableObject {
    @Published var value1: Int = 0
    @Published var value2: Int = 0
    
    
    func incValue1() {
        value1 += 1
    }
    
    func incValue2() {
        value2 += 1
    }
}

struct InnerView: View {
    
    var body: some View {
        composeBody()
    }
    
    @ViewBuilder func composeBody() -> some View {
        let _ = Self._printChanges()
        Text("I'm inner view")
    }
}

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentation
    @ObservedObject private var viewModel = ContentViewModel()
    
    var body: some View {
        composeBody()
    }
    
    @ViewBuilder func composeBody() -> some View {
        let _ = Self._printChanges()
        NavigationView {
            VStack {
                NavigationLink("Go to next view") {
                    InnerView()
                }
                HStack {
                    Button("Inc value1") {
                        viewModel.incValue1()
                    }
                    Text("Value1: \(viewModel.value1)")
                }
                HStack {
                    Button("Inc value2") {
                        viewModel.incValue2()
                    }
                    Text("Value2: \(viewModel.value2)")
                }
            }
        }.debug()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
