//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State var text1: String = ""
    @State var text2: String = ""
    
    var body: some View {
        VStack {
            Text("SearchBar text1: \(text1)")
            SearchBar(text: $text1)
            
            Text("SearchBar text2: \(text2)")
            SearchBar(text: Binding<String>(get: { text2 },
                                            set: { text2 = $0 }))

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchBar: UIViewRepresentable {
    
    /* Compiles too
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
    }*/
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        /*
        searchBar.delegate = Coordinator(text: $text)
        Bad way of creating delegates: Instance will be immediately deallocated because property 'delegate' is 'weak'
        */
        return searchBar
    }
    
    /* Compiles too
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
    }*/
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
}

extension SearchBar {
    
    final class Coordinator: NSObject, UISearchBarDelegate {
        let text: Binding<String>
        init(text: Binding<String>) {
            self.text = text
        }
        
        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            return true
        }
        
        func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
            return true
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text.wrappedValue = searchText
            print("New text: \(searchText)")
        }
    }
    
}
