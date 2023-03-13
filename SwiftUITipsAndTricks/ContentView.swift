//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

struct Country: Decodable {
    let name: String
}

typealias Countries = [Country]

enum LoadStatus {
    case notLoaded
    case loading
    case loaded(Countries)
    case failure(Error)
}

final class ContentViewModel: ObservableObject {
    //@Published private(set) var countries = Countries()
    @Published var searchToken = ""
    @Published private(set) var loadStatus: LoadStatus = .notLoaded
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = $searchToken
            .filter { token in token.count >= 3 }
            .debounce(for: 0.8, scheduler: DispatchQueue.main)
            .handleEvents(receiveOutput: { output in
                self.loadStatus = .loading
            })
            .subscribe(on: DispatchQueue.global())
            .removeDuplicates()
            .map { token in self.countriesPublisher(withToken: token) }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { receiveCompletion in
                if case .failure(let error) = receiveCompletion {
                    self.loadStatus = .failure(error)
                }
            }
            receiveValue: { countries in
                self.loadStatus = .loaded(countries)
            }
    }
    
    private func countriesPublisher(withToken token: String) -> AnyPublisher<Countries, Error> {
        
        print("Will search for countries with: \(token)")
        
        guard let url = URL(string: "https://restcountries.com/v2/all") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Countries.self, decoder: JSONDecoder())
            .map({ countries in
                countries.filter { country in
                    country.name.contains(token)
                }
            })
            .eraseToAnyPublisher()
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        
        NavigationStack {
            switch viewModel.loadStatus {
            case .loaded(let countries):
                List(countries, id: \.name) { country in
                    Text(country.name)
                }
            case .failure(let error):
                Text(error.localizedDescription)
            case .loading:
                ProgressView()
            case .notLoaded:
                Text("")
            }
            
        }.searchable(text: $viewModel.searchToken, prompt: "Country name")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
