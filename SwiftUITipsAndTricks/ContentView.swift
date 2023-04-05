//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI


struct CountriesView: View {
    
    @StateObject var viewModel = CountriesViewModel()
    
    var body: some View {
        NavigationStack {
            switch viewModel.loadStatus {
            case .loaded(let countries):
                List(countries, id: \.name) { country in
                    HStack {
                        if let flagData = viewModel.flagImage(for: country.name),
                            let flag = UIImage(data: flagData) {
                            Image(uiImage: flag)
                                .resizable()
                                .frame(width: 80, height: 60)
                        }
                        /*if let flagImage = country.flagImage {
                            Image(uiImage: flagImage)
                                .resizable()
                                .frame(width: 80, height: 60)
                        }*/
                        Text(country.name)
                    }
                    .onAppear {
                        NSLog("Apperead \(country.name)")
                    }
                    .onDisappear {
                        NSLog("Dispperead \(country.name)")
                    }
                }
            case .failure(let error):
                Text(error.localizedDescription)
            case .loading:
                ProgressView()
            case .notLoaded:
                Text("")
            }
            
        }.searchable(text: $viewModel.searchToken, prompt: "Country name")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
    }
}
