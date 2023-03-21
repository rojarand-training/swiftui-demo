//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

struct Article {
    let text: String
}

enum LoadState {
    case notLoaded
    case loaded(Article)
}

final class ContentViewModel: ObservableObject {
    @Published var loadState: LoadState = .notLoaded
    
    private var cancellable: AnyCancellable?
    
    enum Error: Swift.Error {
        case notAvailable
    }
    
    func reload() {
        loadState = .notLoaded
    }
    
    func load() {
        cancellable = loadArticle()
            .replaceError(with: Article(text: "Could not load"))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { article in
                self.loadState = .loaded(article)
            })
    }
    
    private func loadArticle() -> Future<Article, Error> {
        Future { promise in
            self.loadArticleGCD { article in
                if let article = article {
                    promise(.success(article))
                } else {
                    promise(.failure(Error.notAvailable))
                }
            }
        }
    }
    
    private func loadArticleGCD(handler: @escaping (Article?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now()+2) {
            if Int.random(in: 1...5)%2 == 0 {
                handler(Article(text: "Hello world"))
            } else {
                handler(nil)
            }
        }
    }
}

struct ContentView: View {

    @StateObject private var vm = ContentViewModel()
    
    var body: some View {
        switch vm.loadState {
        case .notLoaded:
            Text("Loading ...").onAppear(perform: vm.load)
        case .loaded(let article):
            VStack {
                Text("Article text: \(article.text)")
                Button("Reload") {
                    vm.reload()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
