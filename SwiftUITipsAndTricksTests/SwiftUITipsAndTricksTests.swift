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

extension FlagURLs {
    static var empty: FlagURLs {
        FlagURLs(png: "", svg: "")
    }
}

extension Array where Element == LoadStatus {
    var countries: Countries? {
        self.reduce(nil) { partialResult, loadStatus in
            if case .loaded(let countryViewsData) = loadStatus {
                return countryViewsData
            } else {
                return partialResult
            }
        }
    }
}


extension Array where Element == String {
    var countries: Countries {
        map { name in Country(name: name, flags: .empty) }
    }
}

extension Array where Element == Country {
    var names: [String] {
        map { country in country.name }
    }
}

extension Array where Element == CountryViewData {
    var names: [String] {
        map { country in country.name }
    }
}

final class SwiftUITipsAndTricksTests: XCTestCase {
    
    func countryService(loading countryNames: [String]) -> CountriesServiceType {
        DefaultCountriesService(cachedCountries: countryNames.map { Country(name: $0, flags: .empty) })
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
        let viewModel = CountriesViewModel(interval: 0.1, countriesService: countriesService)
        let publisher = viewModel.$loadStatus.statusPublisher()
        
        //act
        viewModel.searchToken = "many"
        let _ = try awaitPublisher(publisher, timeout: 1).countries

        //act
        viewModel.searchToken = "many"//again call for many
       
        let result = receiveResult(from: publisher, withTimeout: 1)
        //let result = publisher.awaitResult(withTimeout: 1)
        XCTAssertTrue(result.isTimeout)
    }
    
    func test_load_multiple_times_for_different_tokens() async throws {
        
        //arrange
        let countriesService = countryService(loading: ["Poland", "Germany", "England"])
        //we need at least minimal interval because publisher can emit when searchToken is assigned and nothing will observe/wait for result
        let viewModel = CountriesViewModel(interval: 0.1, countriesService: countriesService)
        let publisher = viewModel.$loadStatus.statusPublisher()
        
        //act
        ["Pola", "Polan", "Poland"].forEach { token in
            viewModel.searchToken = token
            let result = publisher.awaitResult(withTimeout: 1)
            //assert
            XCTAssertTrue(result.isSuccess, "assas")
        }
    }
}

enum AwaitResult<T>{
    case success(T)
    case timeout
    case failure(Error)
}

extension AwaitResult {
    var isSuccess: Bool {
        if case .success(_) = self {
            return true
        } else {
            return false
        }
    }
    
    var isTimeout: Bool {
        if case .timeout = self {
            return true
        } else {
            return false
        }
    }
}

extension Publisher {   
    //Does not work. Does not receive results
    func awaitResult(withTimeout timeout: TimeInterval) -> AwaitResult<Output> {
        
        let token = Int.random(in: 1...1000)
        NSLog("Will wait token: \(token)")
        
        let semaphore = DispatchSemaphore(value: 0)
        var receivedResult: Output?
        var receivedError: Error?
        let cancellable = self.timeout(.seconds(timeout), scheduler: DispatchQueue.global())
            .sink { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                }
                NSLog("RES:completion received \(token)")
                semaphore.signal()
            } receiveValue: { result in
                NSLog("RES:result received \(token)")
                receivedResult = result
                semaphore.signal()
            }
       
        _ = semaphore.wait(timeout: .now()+(timeout))
        cancellable.cancel()
        
        NSLog("Did wait token: \(token)")
        
        if let receivedError {
            NSLog("RES:failure")
            return .failure(receivedError)
        } else if let receivedResult {
            NSLog("RES:success")
            return .success(receivedResult)
        } else {
            NSLog("RES:timeout")
            return .timeout
        }
    }
}

extension XCTestCase {
    
    func receiveResult<T: Publisher>(
        from publisher: T,
        withTimeout timeout: TimeInterval = 10
    ) -> AwaitResult<T.Output> {
        
        let expectation = self.expectation(description: "Awaiting for load results")
        var receivedResult: T.Output?
        var receivedError: Error?
        let cancellable = publisher
            .timeout(.seconds(timeout), scheduler: DispatchQueue.global())
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    receivedError = error
                    expectation.fulfill()
                }
            } receiveValue: { result in
                receivedResult = result
            }
        
        waitForExpectations(timeout: timeout*2)
        cancellable.cancel()
        
        if let receivedError {
            return .failure(receivedError)
        } else if let receivedResult {
            return .success(receivedResult)
        } else {
            return .timeout
        }
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

