//
//  CountriesViewModel.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 05/04/2023.
//

import Foundation
import Combine

enum LoadStatus {
    case notLoaded
    case loading
    case loaded(Countries)
    case failure(Error)
}

final class CountriesViewModel: ObservableObject {
    
    @Published var searchToken = ""
    @Published private(set) var loadStatus: LoadStatus = .notLoaded
    
    private var cancellable: AnyCancellable?
    
    private var flagCache = CountryViewsData()
    
    func flagImage(for countryName: String) -> Data? {
        flagCache.first { countryViewData in
            countryViewData.name == countryName
        }?.flagData
    }
    
    init(interval: TimeInterval = 0.8,
         countriesService: CountriesServiceType = DefaultCountriesService(),
         countryViewDataService: CountryViewDataServiceType = DefaultCountryViewDataService()) {
        cancellable = $searchToken
            .debounce(for: .seconds(interval), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { token in token.count >= 3 }
            .logOutput(enabled: true, prefixedWith: "Tokens:")
            .handleEvents(receiveOutput: { output in
                self.loadStatus = .loading
            })
            .subscribe(on: DispatchQueue.global())
            .map { token in countriesService.loadCountries(withToken: token) }
            .switchToLatest()
            .flatMap { countries in
                countryViewDataService.loadCountryViewsData(for: countries)
                    .handleEvents(receiveOutput:  { countryViewsData in
                        self.flagCache = countryViewsData
                    })
                    .map { _ in
                        countries
                    }
            }
            .logOutput(enabled: true, prefixedWith: "Loaded flags:")
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

extension Publisher {
    
    func logOutput(enabled: Bool, prefixedWith actionName: @escaping @autoclosure () -> String) -> AnyPublisher<Output, Failure> {
        if enabled {
            return handleEvents( receiveOutput: { output in
                NSLog("\(actionName()) \(output)")
            })
            .eraseToAnyPublisher()
        } else {
            return self.eraseToAnyPublisher()
        }
    }
    
    func logCompletion(of step: String) -> AnyPublisher<Output, Failure> {
        handleEvents( receiveCompletion: { _ in
            NSLog("\(step) completed")
        })
        .eraseToAnyPublisher()
    }
}
