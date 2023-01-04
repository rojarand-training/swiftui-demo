//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var repaint = false
    var body: some View {
        /*
        ZStack {
            if repaint {
                loadingView()
            }
            ErrorView(UnknownError()) {
                repaint.toggle()
            }
        }*/
        
        NavigationView {
            Scaffolding(StringLoader()) { result, loading in
                VStack {
                    Text("Welcome to Scaffolding example")
                        .font(.title)
                        .foregroundColor(.secondary)
                        .padding()
                    NavigationLink("Go to AsyncContentView example", destination: AsyncContentViewExample())
                        .padding()
                    Button {
                        Task {
                            await loading()
                        }
                    } label: {
                        Text("Reload")
                    }
                    Text("Result: \(result)")
                }
            }
        }
        
    }
}

struct AsyncContentViewExample: View {
    let loader = SampleLoader()
    var body: some View {
        AsyncContentView(loader) { result in
            VStack {
                Text("Loaded: \(result)")
                Button("Reload") {
                    loader.load()
                }
            }
        }.onAppear{ loader.load() }
    }
}

class SampleLoader: Loadable {
    @Published var state: LoadingState<String> = .neverLoaded
    
    @MainActor
    func load() {
        Task {
            do {
                state = .loading
                state = .success(result: try await StringLoader().load())
            } catch {
                state = .failure(error: error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
