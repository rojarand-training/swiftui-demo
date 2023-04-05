//
//  CountriesService.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 05/04/2023.
//

import Foundation
import Combine

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
            .decode(type: CountryNetworkModels.self, decoder: JSONDecoder())
            .map({ countryNetworkModels in
                countryNetworkModels.enumerated().map { idx, model in
                    NSLog("idx: \(idx) of: \(model.name)")
                    return Country(id: idx, name: model.name, flags: model.flags)
                }
            })
            .handleEvents(receiveOutput: { countries in
                self.cachedCountries = countries
            })
            .eraseToAnyPublisher()
    }
}
