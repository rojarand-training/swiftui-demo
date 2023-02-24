//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

@dynamicMemberLookup
final class Observalble<Value>: ObservableObject {
    
    @Published var value: Value
    private var cacellable: AnyCancellable?
    
    init<P: Publisher>(value: Value, publisher: P) where P.Output == Value, P.Failure == Never {
        self.value = value
        self.cacellable = publisher.assign(to: \.value, on: self)
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<Value, T>) -> T {
        value[keyPath: keyPath]
    }
}

struct Article {
    let title: String
    let author: String
}

struct ContentView: View {
    
    @ObservedObject private var articleVM: Observalble<Article>
    private let authorSubject = PassthroughSubject<Article, Never>()
    init() {
        let article = Article(title: "Hello World", author: "Author")
        articleVM = Observalble(value: article, publisher: authorSubject)
    }
    
    var body: some View {
        VStack {
            Text("Author: \(articleVM.author)")
            Text("Title: \(articleVM.title)")
            
            Button("Author 1") {
                let article = Article(title: "Hello World1", author: "Author1")
                authorSubject.send(article)
            }
            Button("Author 2") {
                let article = Article(title: "Hello World2", author: "Author2")
                authorSubject.send(article)
            }
            Button("Author 3") {
                let article = Article(title: "Hello World3", author: "Author3")
                authorSubject.send(article)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
