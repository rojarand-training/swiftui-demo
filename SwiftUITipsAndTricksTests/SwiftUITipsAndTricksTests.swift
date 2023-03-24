//
//  SwiftUITipsAndTricksTests.swift
//  SwiftUITipsAndTricksTests
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import XCTest
import Combine
@testable import SwiftUITipsAndTricks

struct CountriesServiceStub: CountriesServiceType {

    private let countries: Countries
    
    init(countries: Countries) {
        self.countries = countries
    }
    
    func loadCountries(withToken token: String) -> AnyPublisher<Countries, Error> {
        Just(countries)
            .map { countries in
                countries.with(tokenInName: token)
            }
            .delay(for: 1.0, scheduler: DispatchQueue.global())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}


extension Combine.Published<LoadStatus>.Publisher {
    func statusPublisher() -> AnyPublisher<[LoadStatus], Never> {
        self.dropFirst().collect(2).first().eraseToAnyPublisher()
    }
}

extension Array where Element == LoadStatus {
    var countries: Countries? {
        self.reduce(nil) { partialResult, loadStatus in
            if case .loaded(let countries) = loadStatus {
                return countries
            } else {
                return partialResult
            }
        }
    }
}


extension Array where Element == String {
    var countries: Countries {
        map { name in Country(name: name) }
    }
}

extension Array where Element == Country {
    var names: [String] {
        map { country in country.name }
    }
}

final class SwiftUITipsAndTricksTests: XCTestCase {
    
    func countryService(loading countryNames: [String]) -> CountriesServiceType {
        DefaultCountriesService(cachedCountries: countryNames.map { Country(name: $0) })
    }
    
    func test_loads_countries_contianing_token_in_name() throws {
        
        //arrange
        let countriesService = countryService(loading: ["Poland", "Germany", "England"])
        let viewModel = CountriesViewModel(interval: 0.0, countriesService: countriesService)
        let publisher = viewModel.$loadStatus.statusPublisher()
        
        //act
        viewModel.searchToken = "land"
        
        //assert
        let loadedCountries = try awaitPublisher(publisher, timeout: 1).countries!
        XCTAssertEqual(["Poland", "England"], loadedCountries.names)
    }
    
    func test_loads_countries_for_last_token_only() throws {
        
        //arrange
        let countriesService = countryService(loading: ["Poland", "Germany", "England"])
        let viewModel = CountriesViewModel(interval: 0.0, countriesService: countriesService)
        let publisher = viewModel.$loadStatus.statusPublisher()
        
        //act
        viewModel.searchToken = "land"
        viewModel.searchToken = "many"
        
        //assert
        let loadedCountries = try awaitPublisher(publisher, timeout: 1).countries!
        XCTAssertEqual(["Germany"], loadedCountries.names)
    }
    
    func test_does_not_load_for_duplicated_token() throws {
        
        //arrange
        let countriesService = countryService(loading: ["Poland", "Germany", "England"])
        let viewModel = CountriesViewModel(interval: 0.0, countriesService: countriesService)
        let publisher = viewModel.$loadStatus.statusPublisher()
        
        //act
        viewModel.searchToken = "many"
        let _ = try awaitPublisher(publisher, timeout: 1).countries

        //act
        viewModel.searchToken = "many"//again call for many
        
        let expectation = self.expectation(description: "Awaiting for load results")
       
        var receivedStatuses: [LoadStatus]? = nil
        let cancellable = publisher
            .timeout(.seconds(1), scheduler: DispatchQueue.global())
            .sink { completion in expectation.fulfill() }
            receiveValue: { statuses in receivedStatuses = statuses }
        
        waitForExpectations(timeout: 2.0)
        XCTAssertNil(receivedStatuses)
        XCTAssertNotNil(cancellable)
    }
    
}

extension XCTestCase {
    
    func awaitPublisher1<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output? {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")
        
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }
                
                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )
        
        // Just like before, we await the expectation that we
        // created at the top of our test, and once done, we
        // also cancel our cancellable to avoid getting any
        // unused variable warnings:
        waitForExpectations(timeout: timeout)
        cancellable.cancel()
        
        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        return try result?.get()
    }
    
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")
        
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }
                
                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )
        
        // Just like before, we await the expectation that we
        // created at the top of our test, and once done, we
        // also cancel our cancellable to avoid getting any
        // unused variable warnings:
        waitForExpectations(timeout: timeout)
        cancellable.cancel()
        
        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )
        
        return try unwrappedResult.get()
    }
}

