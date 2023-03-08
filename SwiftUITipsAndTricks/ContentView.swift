//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct UIViewWrapper<V: UIView>: UIViewRepresentable {
    
    private let viewMaking: () -> V
    private let viewUpdating: (V, Context) -> Void
    
    init(viewMaking: @escaping () -> V,
         viewUpdating: @escaping (V, Context) -> Void) {
        
        self.viewMaking = viewMaking
        self.viewUpdating = viewUpdating
    }
    
    func makeUIView(context: Context) -> V {
        viewMaking()
    }
    
    func updateUIView(_ uiView: V, context: Context) {
        viewUpdating(uiView, context)
    }
}

struct ContentView: View {

    @State private var isLoading = false
    
    var body: some View {
        VStack {
            UIViewWrapper {
                UIActivityIndicatorView()
            } viewUpdating: { indicator, _ in
                if isLoading {
                    indicator.startAnimating()
                } else {
                    indicator.stopAnimating()
                }
            }
            Toggle(isLoading ? "Off" : "On", isOn: $isLoading)
                .toggleStyle(.button)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
