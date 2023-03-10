//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

struct ArticleModels: Decodable {
    let items: Articles
}

struct Article: Decodable {
    let title: String
    let id: Int
}

typealias Articles = [Article]

struct SearchArticlesURLFormatter {
    static let host = "pomoc.bluemedia.pl"
    static let scheme = "https"

    static func formatURL(containing searchedText: String) throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = Self.scheme
        urlComponents.host = Self.host
        urlComponents.path = "/search-engine/search"
        urlComponents.queryItems = [URLQueryItem(name: "query", value: searchedText)]
        if let url = urlComponents.url {
            return url
        } else {
            throw URLError(.badURL)
        }
    }
}

final class ContentViewModel: ObservableObject {
    
    @Published private(set) var articles = Articles()
    @Published var searchToken: String = ""
    
    private var cancellable: AnyCancellable?
    
    
    init() {
        cancellable = articlePublisher
            .receive(on: DispatchQueue.main)
            .sink { _ in
            
        } receiveValue: { articles in
            self.articles = articles
        }
    }
    
    private var articlePublisher: AnyPublisher<Articles, Error> {
        $searchToken
            .filter{ token in !token.isEmpty }
            .debounce(for: 0.5, scheduler: DispatchQueue.global())
            .tryMap { token in
                try SearchArticlesURLFormatter.formatURL(containing: String(token))
            }
            .map({ url in
                URLSession.shared.dataTaskPublisher(for: url)
                    .mapError { urlError in
                        urlError as Error
                    }
            })
            .switchToLatest()
            .tryMap({ output in
                try JSONDecoder().decode(ArticleModels.self, from: output.data).items
            })
            .eraseToAnyPublisher()
    }
}

struct ContentView: View {
    @StateObject private var vm = ContentViewModel()
    var body: some View {
        NavigationView {
            VStack {
                List(vm.articles, id: \.id) { article in
                    Text(article.title)
                }
                .searchable(text: $vm.searchToken, prompt: "Article title")
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
