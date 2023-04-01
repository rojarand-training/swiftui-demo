//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct Country: Decodable {
    let name: String
}

typealias Countries = [Country]

class Future<Value> {
    
    typealias Result = Swift.Result<Value, Error>
    typealias ResultCallback = (Result) -> Void
    
    private var callbacks = [ResultCallback]()
    
    fileprivate var result: Result? {
        didSet {
            result.map(report)
        }
    }
    
    func observe(callback: @escaping ResultCallback) {
        callbacks.append(callback)
    }
    
    private func report(result: Result) {
        NSLog("Number of callbacks: %d", callbacks.count)
        callbacks.forEach { callback in
            callback(result)
        }
        callbacks = []
    }
    
    func chained<T>(callback: @escaping (Value)->Future<T>) -> Future<T> {
        let promise = Promise<T>()
        observe { result in
            switch result {
            case .success(let value):
                let future = callback(value)
                future.observe { result in
                    switch result {
                    case .success(let value):
                        promise.resolve(value)
                    case .failure(let error):
                        promise.reject(error)
                    }
                }
            case .failure(let error):
                promise.reject(error)
            }
        }
        return promise
    }
    
    func decoded<T>(type: T.Type, using decoder: JSONDecoder = .init()) -> Future<T> where Value == Data, T: Decodable {
        
        chained { value in
            let promise = Promise<T>()
            DispatchQueue.global().async {
                do {
                    promise.resolve(try decoder.decode(type, from: value))
                } catch {
                    promise.reject(error)
                }
            }
            return promise
        }
        
    }
}

class Promise<Value>: Future<Value> {
    func resolve(_ value: Value) {
        result = .success(value)
    }
    
    func reject(_ error: Error) {
        result = .failure(error)
    }
}

extension URLSession {
    func request(for url: URL) -> Future<Data> {
        
        let promise = Promise<Data>()
        let task = dataTask(with: url) { data, urlResponse, error in
            if let error {
                promise.reject(error)
            } else {
                promise.resolve(data ?? Data())
            }
        }
        defer {
            task.resume()
        }
        return promise
    }
    
    func load<D: Decodable>(for url: URL) -> Future<D> {
        
        let promise = Promise<D>()
        let task = dataTask(with: url) { data, urlResponse, error in
            if let error {
                promise.reject(error)
            } else {
                do {
                    let result = try JSONDecoder().decode(D.self, from: data ?? Data())
                    promise.resolve(result)
                } catch {
                    promise.reject(error)
                }
            }
        }
        defer {
            task.resume()
        }
        return promise
    }
}

final class ContentViewModel: ObservableObject {
    
    @Published var countries = Countries()
    
    func loadCountries() {
        let url = URL(string: "https://restcountries.com/v2/all")!
        
        if Int.random(in: 1...10) % 2 == 0 {
            URLSession.shared.request(for: url)
                .decoded(type: Countries.self)
                .observe { result in
                    switch result {
                    case .success(let countries):
                        DispatchQueue.main.async {
                            self.countries = countries
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
        } else {
            let future: Future<Countries> = URLSession.shared.load(for: url)
            future.observe { result in
                switch result {
                case .success(let countries):
                    DispatchQueue.main.async {
                        self.countries = countries
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct ContentView: View {
    
    @StateObject private var vm = ContentViewModel()
    
    var body: some View {
        _body()
    }
    
    private func _body() -> some View {
        return VStack {
            Button("Load countries") {
                vm.loadCountries()
            }
            
            List(vm.countries, id: \.name) { country in
                Text(country.name)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
