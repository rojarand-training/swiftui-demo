//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

struct Flags: Decodable {
    let png: String
}
struct CountryNetworkModel: Decodable {
    let name: String
    let flags: Flags
}

typealias CountryNetworkModels = [CountryNetworkModel]

struct Country {
    let name: String
    let pngData: Data
}

typealias Countries = [Country]

final class ContentViewModel: ObservableObject {
    
    @Published var countries = Countries()
    private var cancellable: AnyCancellable?
    init () {
        
    }
    
    func load() {
        cancellable = countryPublisher.receive(on: DispatchQueue.main)
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { countries in
                self.countries = countries
            }
    }
    
    var countryPublisher: AnyPublisher<Countries, Error> {
        
        guard let url = URL(string: "https://restcountries.com/v2/all") else {
            let error = URLError(.badURL)
            return Fail(outputType: Countries.self, failure: error).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CountryNetworkModels.self, decoder: JSONDecoder())
            .map { models in
                models.prefix(10)
            }
            .tryMap { netModels -> [(name: String, url: URL)] in
                try netModels.map { netModel in
                    guard let url = URL(string: netModel.flags.png) else {
                        throw URLError(.badURL)
                    }
                    return (name: netModel.name, url: url)
                }
            }
            .flatMap { (models) -> Publishers.MergeMany<AnyPublisher<Country, Error>> in
                let tasks = models.map { (model) -> AnyPublisher<Country, Error> in
                    return URLSession.shared.dataTaskPublisher(for: model.url)
                        .map { (data: Data, response: URLResponse) in
                            Country(name: model.name, pngData: data)
                        }
                        .mapError({ failure in
                            failure as Error
                        })
                        .eraseToAnyPublisher()
                }
                return Publishers.MergeMany(tasks)
            }
            .collect()
            .eraseToAnyPublisher()
    }
}

struct ContentView: View {
    
    @ObservedObject private var vm = ContentViewModel()
    var body: some View {
        List(vm.countries, id: \.name) { country in
            HStack {
                Text("\(country.name)")
                Spacer()
                if let uiImage = UIImage(data: country.pngData) {
                    Image(uiImage: uiImage)
                        .frame(maxWidth: 80)
                }
            }
        }.onAppear {
            vm.load()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
