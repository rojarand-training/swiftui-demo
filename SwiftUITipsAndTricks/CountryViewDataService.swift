//
//  CountryViewDataService.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 05/04/2023.
//

import Foundation
import Combine

protocol CountryViewDataServiceType {
    func loadCountryViewsData(for countries: Countries) -> AnyPublisher<CountryViewsData, Error>
}

protocol DataServiceType {
    func load(from url: URL) -> AnyPublisher<Data, Error>
}

struct DefaultDataService: DataServiceType {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func load(from url: URL) -> AnyPublisher<Data, Error> {
        urlSession.dataTaskPublisher(for: url)
            .map { (data: Data, response: URLResponse) in
                data
            }.mapError { error in
                URLError(.badURL) as Error
            }.eraseToAnyPublisher()
    }
}

struct DefaultCountryViewDataService: CountryViewDataServiceType {
    
    private let dataService: DataServiceType
    
    init(dataService: DataServiceType = DefaultDataService()) {
        self.dataService = dataService
    }
    
    func loadCountryViewsData(for countries: Countries) -> AnyPublisher<CountryViewsData, Error> {
        countries.publisher
            .handleEvents(receiveOutput: { output in
                NSLog("Will load flag for: \(output.name)")
            })
            .flatMap { country in
                guard let url = country.flagURL else {
                    return Just(CountryViewData(name: country.name, flagImageData: nil))
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
                return dataService.load(from: url)
                    .map { data in CountryViewData(name: country.name, flagImageData: data) }
                    .eraseToAnyPublisher()
            }
            .handleEvents(receiveOutput: { output in
                NSLog("Did load flag for: \(output.name)")
            })
            .collect()
            .eraseToAnyPublisher()
    }
}
