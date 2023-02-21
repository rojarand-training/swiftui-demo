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

struct GeneralError: Error {
    var localizedDescription: String {
        "General network error occurred."
    }
}
struct BadStatusCodeError: Error {
    var localizedDescription: String {
        "Bad status code received."
    }
}

final class ContentViewModel: ObservableObject {
    
    @Published var countries: Countries = []
    @Published var errorMessage: String = ""
    private var cancellable: AnyCancellable?
    
    func loadWithDefaultErrorHandling() {
        errorMessage = ""
        cancellable = countryPublisherWithBadUrl
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.errorMessage = ""
                }
            } receiveValue: { countries in
                self.countries = countries
            }
    }
    
    func loadWithErrorMapping() {
        errorMessage = ""
        cancellable = countryPublisherWithBadUrl
            .mapError({ error in
                GeneralError()
            })
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.errorMessage = ""
                }
            } receiveValue: { countries in
                self.countries = countries
            }
    }
    
    func loadWithTryMap() {
        errorMessage = ""
        cancellable = countryPublisherWithTryMap
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.errorMessage = ""
                }
            } receiveValue: { countries in
                self.countries = countries
            }
    }
    
    func loadWithMapToResult() {
        errorMessage = ""
        cancellable = countryPublisherWithResultAndMap
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.errorMessage = ""
                }
            } receiveValue: { countries in
                self.countries = countries
            }
    }
    
    private var countryPublisherWithBadUrl: AnyPublisher<Countries, Error> {
        guard let url = URL(string: "https://restcountries.com/v2/all-bad") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Countries.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private var countryPublisherWithTryMap: AnyPublisher<Countries, Error> {
        guard let url = URL(string: "https://restcountries.com/v2/all") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                guard httpResponse.statusCode == 401 else {
                    throw BadStatusCodeError()
                }
                return data
            }
            .decode(type: Countries.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private var countryPublisherWithResultAndMap: AnyPublisher<Countries, Error> {
        guard let url = URL(string: "https://restcountries.com/v2/all") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data: Data, response: URLResponse) -> Result<Countries, any Error> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return .failure(URLError(.badServerResponse))
                }
                guard httpResponse.statusCode == 401 else {
                    return .failure(BadStatusCodeError())
                }
                do {
                    let countries = try JSONDecoder().decode(Countries.self, from: data)
                    return .success(countries)
                } catch {
                    return .failure(error)
                }
            }
            .tryMap({ result in
                switch result {
                case .failure(let error):
                    throw error
                case .success(let countries):
                    return countries
                }
            })
            .eraseToAnyPublisher()
    }
    
}

struct ContentView: View {
    
    @ObservedObject private var vm = ContentViewModel()
    
    var body: some View {
        VStack {
            Button {
                vm.loadWithDefaultErrorHandling()
            } label: {
                Text("Load with default error handling")
                    .alertButton()
            }
            Button {
                vm.loadWithErrorMapping()
            } label: {
                Text("Load with error mapping: mapError")
                    .alertButton()
            }
            Button {
                vm.loadWithTryMap()
            } label: {
                Text("Load with throwing error in tryMap")
                    .alertButton()
            }
            Button {
                vm.loadWithMapToResult()
            } label: {
                Text("Load with map to result")
                    .alertButton()
            }
            
            if !vm.errorMessage.isEmpty {
                Text(vm.errorMessage)
                    .font(.subheadline)
                    .foregroundColor(.red)
            }
            List(vm.countries, id: \.name) { country in
                Text(country.name)
            }
        }
    }
}

struct TextAsButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .background(.red)
            .cornerRadius(12)
    }
}

extension Text {
    func alertButton() -> some View {
        self.modifier(TextAsButton())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

