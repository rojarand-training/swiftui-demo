//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine
import FlagsLib
import PodFlagsLib2

struct Country: Decodable {
    let name: String
    let alpha2Code: String
}

extension Country: Identifiable {
    var id: String {
        name
    }
}

typealias Countries = [Country]

struct CountriesService {
    
    var countryPublisher: AnyPublisher<Countries, Error> {
        fileCountryPublisher
    }
    
    private var fileCountryPublisher: AnyPublisher<Countries, Error> {
        guard let url = Bundle(for: ContentViewModel.self)/*Bundle.main*/.url(forResource: "countries", withExtension: "json") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return countryPublisher(forDataAt: url)
    }
    
    private var networkCountryPublisher: AnyPublisher<Countries, Error> {
        guard let url = URL(string: "https://restcountries.com/v2/all") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return countryPublisher(forDataAt: url)
    }
    
    private func countryPublisher(forDataAt url: URL) -> AnyPublisher<Countries, Error> {
         URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Countries.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

final class ContentViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var countries = Countries()
    @Published var searchToken: String = ""
    
    init() {
        countriesLoading
            .receive(on: DispatchQueue.main)
            .sink { completion in
                NSLog("Completed")
            } receiveValue: { [weak self] countries in
                NSLog("Received: \(countries)")
                self?.countries = countries
            }.store(in: &cancellables)
    }
    
    private var countriesLoading: AnyPublisher<Countries, Error> {
        $searchToken
            .filter { token in token.isEmpty || token.count >= 3 }
            .debounce(for: .seconds(0.6), scheduler: DispatchQueue.main)
            .flatMap { token in
                CountriesService().countryPublisher
                    .map { $0.filter { country in
                        token.isEmpty || country.name.localizedStandardContains(token)
                    } }
            }
            .eraseToAnyPublisher()
    }
}

struct CountryRow: View {
    private let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var body: some View {
        HStack {
            Text(country.name)
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 60)
            }
        }
    }
    
    private var image: UIImage? {
        let tag = country.alpha2Code.lowercased()
        guard let data = 
            FlagsLib.getFlagData(byCountryTag: tag) ??
            PodFlags.getResourcesData(byCountryTag: tag) ??
            PodFlags.getBundleData(byCountryTag: tag) else {
            return nil
        }
        return UIImage(data: data)
    }
}

struct ContentView: View {

    @StateObject var vm = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            List(vm.countries) { country in
                CountryRow(country: country)
            }
        }
        .searchable(text: $vm.searchToken)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
