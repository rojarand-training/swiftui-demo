//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

struct Country: Identifiable, Decodable {
    let name: String
    var id: String { name }
}

typealias Countries = [Country]

enum LoadError: Error {
    case noData
}

final class ContentViewModel: ObservableObject {
    
    @Published var countries: Countries = []
    
    private var cancellable: AnyCancellable?
    
    func load() {
        countries = []
        cancellable = countriesLocalStoragePublisher()
            .replaceError(with: [Country]())
            .flatMap { countries in
                if countries.isEmpty {
                    return self.countriesRemoteStoragePublisher()
                } else {
                    return Just(countries)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
            }
            .receive(on: RunLoop.main)
            .sink { error in
                
            } receiveValue: { countries in
                self.countries = countries
            }
    }
    
    private func countriesLocalStoragePublisher() -> AnyPublisher<Countries, Error> {
        if Int.random(in: 1...10)%2 == 0 {
            return Fail(error: LoadError.noData).eraseToAnyPublisher()
        } else {
            return Just([Country(name: "Poland"),
                         Country(name: "Germany"),
                         Country(name: "UK")])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
    }
    
    private func countriesRemoteStoragePublisher() -> AnyPublisher<Countries, Error> {
        guard let url = URL(string: "https://restcountries.com/v2/all") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Countries.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

struct ContentView: View {
    @ObservedObject var vm = ContentViewModel()
    var body: some View {
        VStack {
            if vm.countries.isEmpty {
                ProgressView()
                    .onAppear(perform: vm.load)
            } else {
                Button("Reload") {
                    vm.load()
                }
                List(vm.countries) { country in
                    Text(country.name)
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
