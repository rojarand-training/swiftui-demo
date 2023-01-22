//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

struct Country: Identifiable, Decodable {
    var id: String {
        return name
    }
    let name: String
}

class ContentViewModel: ObservableObject {
    
    @Published var countries: [Country] = []
    private var cancellable: Cancellable?
    
    func load() {
        cancellable = loadCountries()
            .sink { result in
                print(result)
            } receiveValue: { countries in
                self.countries = countries
            }
    }
    
    private func loadCountries() -> AnyPublisher<[Country], Error> {
        guard let url = URL(string: "https://restcountries.com/v2/all") else {
            let error: Error = URLError(.badURL)
            return Fail(outputType: [Country].self, failure: error).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Country].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

struct ContentView: View {
    
    @ObservedObject private var viewModel = ContentViewModel()
    
    var body: some View {
        if viewModel.countries.isEmpty {
            ProgressView()
                .onAppear { viewModel.load() }
        } else {
            List {
                ForEach(viewModel.countries) { country in
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
