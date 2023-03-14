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

protocol CountriesServiceType {
    func loadCountries(withToken token: String) -> AnyPublisher<Countries, Error>
}

extension Array where Element == Country {
    func with(tokenInName token: String) -> Countries {
        let lowercasedToken = token.lowercased()
        return filter { country in
            country.name.lowercased().contains(lowercasedToken)
        }
    }
}

final class DefaultCountriesService: CountriesServiceType {
    
    private var cachedCountries: Countries
    
    init(cachedCountries: Countries = Countries()) {
        self.cachedCountries = cachedCountries
    }
    
    func loadCountries(withToken token: String) -> AnyPublisher<Countries, Error> {
        return countryPublisher()
            .map { countries in
                countries.with(tokenInName: token)
            }
            .eraseToAnyPublisher()
    }
    
    private func countryPublisher() -> AnyPublisher<Countries, Error> {
        if !cachedCountries.isEmpty {
            return cachedCountriesPublisher
        } else {
            return networkCountriesPublisher
        }
    }
    
    private var cachedCountriesPublisher: AnyPublisher<Countries, Error> {
        cachedCountries.publisher
            .collect()
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    private var networkCountriesPublisher: AnyPublisher<Countries, Error> {
        guard let url = URL(string: "https://restcountries.com/v2/all") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Countries.self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { countries in
                self.cachedCountries = countries
            })
            .eraseToAnyPublisher()
    }
}

final class CountriesViewModel: ObservableObject {
    
    @Published var searchToken = ""
    @Published private(set) var loadStatus: LoadStatus = .notLoaded
    
    private var cancellable: AnyCancellable?
    
    init(interval: TimeInterval = 0.8, countriesService: CountriesServiceType = DefaultCountriesService()) {
        cancellable = $searchToken
            .filter { token in token.count >= 3 }
            .debounce(for: .seconds(interval), scheduler: DispatchQueue.main)
            .handleEvents(receiveOutput: { output in
                self.loadStatus = .loading
            })
            .subscribe(on: DispatchQueue.global())
            .removeDuplicates()
            .map { token in countriesService.loadCountries(withToken: token) }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { receiveCompletion in
                if case .failure(let error) = receiveCompletion {
                    self.loadStatus = .failure(error)
                }
            } receiveValue: { countries in
                self.loadStatus = .loaded(countries)
            }
    }
}

struct CountriesView: View {
    
    @StateObject var viewModel = CountriesViewModel()
    
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
        CountriesView()
    }
}
