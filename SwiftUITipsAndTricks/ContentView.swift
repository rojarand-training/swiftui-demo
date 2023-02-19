//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

struct URLAsyncIterator: AsyncIteratorProtocol {
    
    private let urls: [URL]
    private let urlSession: URLSession = .shared
    private var index = 0
    
    init(urls: [URL]) {
        self.urls = urls
    }
    
    mutating func next() async throws -> Data? {
        guard index < urls.count else { return nil }
        
        let (data, response) = try await urlSession.data(from: urls[index])
        guard let httpResponse = response as? HTTPURLResponse else { return nil }
        guard httpResponse.statusCode == 200 else { return nil }
        
        index += 1
        return data
    }
}

struct URLSequence: AsyncSequence {
    typealias Element = Data
    
    let urls: [URL]
    func makeAsyncIterator() -> URLAsyncIterator {
        URLAsyncIterator(urls: urls)
    }
}

@MainActor final class ContentViewModel: ObservableObject {
    
    private let urlSequence: URLSequence
    @Published var images: [Data?] = []
    init() {
        urlSequence = URLSequence(urls: ContentViewModel.makeURLS())
    }
    
    func load() {
        Task {
            images = [nil]
            for try await data in urlSequence {
                images[images.count-1] = data
                images.append(nil)
            }
            images.removeLast()
        }
    }
    
    private static func makeURLS() -> [URL] {
        (1...10).compactMap { _ in
            URL(string: "https:/picsum.photos/300/200")
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var vm = ContentViewModel()
    
    var body: some View {
        VStack {
            Button {
                vm.load()
            } label: {
                Text("Reaload")
                    .padding()
                    .foregroundColor(.white)
                    .background(.green)
                    .cornerRadius(12)
            }
            List(Array(vm.images.enumerated()), id: \.offset) { indexedData in
                if let data = indexedData.element {
                    if let image = UIImage(data: data) {
                        Image(uiImage: image)
                    }
                } else {
                    ProgressView()
                }
            }
        }
        Text("Hello World")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
