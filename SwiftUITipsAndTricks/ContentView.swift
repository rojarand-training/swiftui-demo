//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct CityDetails {
    
}

struct City: Identifiable {
    var id: String { return name }
    let name: String
    let details: CityDetails
}

struct Province: Identifiable {
    var id: String { return name }
    let name: String
    let cities: [City]
}

struct Country: Identifiable {
    var id: String { return name }
    let name: String
    let provinces: [Province]
}

let europeanCountries = [
    Country(name: "Poland",
            provinces: [Province(name: "Podlaskie",
                                 cities: [
                                    City(name: "Suwałki", details: (CityDetails())),
                                    City(name: "Białystok", details: (CityDetails())),
                                    City(name: "Łomża", details: (CityDetails()))]),
                        Province(name: "Mazowieckie",
                                 cities: [
                                    City(name: "Warszawa", details: (CityDetails())),
                                    City(name: "Radom", details: (CityDetails())),
                                    City(name: "Ciechanów", details: (CityDetails())),
                                    City(name: "Płock", details: (CityDetails())),
                                    City(name: "Ostrołęka", details: (CityDetails())),
                        ])
    ]),
    Country(name: "Germany",
            provinces: [Province(name: "Brandenburg",
                                 cities: [
                                    City(name: "Berlin", details: (CityDetails())),
                                    City(name: "Potsdam", details: (CityDetails()))]),
                        Province(name: "Bayern",
                                 cities: [
                                    City(name: "Munich", details: (CityDetails())),
                                    City(name: "Augsburg", details: (CityDetails())),
                                    City(name: "Nurnberg", details: (CityDetails())),
                        ])
    ]),
]

final class AppNavigation: ObservableObject {
    
    func navigateToProvince(withName: String) {
        
    }
    
    private var selectedProvince = ""
    
    func isProvinceSelected(provinceName: String) -> Binding<Bool> {
        return Binding<Bool> { [weak self] in
            let selectedProvince: String = self?.selectedProvince ?? ""
            print("selected province:\(selectedProvince), province: \(provinceName)")
            return (self?.selectedProvince ) == provinceName
        } set: { [weak self] value in
            self?.selectedProvince = value ? provinceName : ""
            print("New value: \(value) for province: \(provinceName)")
        }
    }
}

struct CityDetailsView: View {
    let city: City
    var body: some View {
        Text("Details of: \(city.name)")
    }
}

struct CityView: View {
    let city: City
    var body: some View {
        VStack {
            Text("Welcome in: \(city.name)")
            NavigationLink("See details") {
                CityDetailsView(city: city)
            }
        }
    }
}

struct ProvinceView: View {
   
    @State var selectedCity = ""
    let province: Province
    func isCityChosen(cityName: String) -> Binding<Bool> {
        return Binding<Bool> {
            print("selected city:\(selectedCity), city: \(cityName)")
            return selectedCity == cityName
        } set: { value in
            selectedCity = value ? cityName : ""
            print("New value: \(value) for province: \(cityName)")
        }
    }
    
    var body: some View {
        VStack{
            Text(province.name)
            List(province.cities) { city in
                NavigationLink(city.name, isActive: isCityChosen(cityName: city.name)) {
                    CityView(city: city)
                }
            }
        }
    }
}

struct CountryView: View {
   
    @State var selectedProvince = ""
    let country: Country
    func isProvinceSelected(provinceName: String) -> Binding<Bool> {
        return Binding<Bool> {
            print("selected province:\(selectedProvince), province: \(provinceName)")
            return selectedProvince == provinceName
        } set: { value in
            selectedProvince = value ? provinceName : ""
            print("New value: \(value) for province: \(provinceName)")
        }
    }
    

    
    var body: some View {
        VStack{
            Text(country.name)
            List(country.provinces) { province in
                NavigationLink(province.name, isActive: isProvinceSelected(provinceName: province.name)) {
                    ProvinceView(province: province)
                }
            }
        }
    }
}

final class CountriesViewModel: ObservableObject {
    @Published var countries: [Country] = []
    func load() {
        countries = europeanCountries
    }
}

struct CountriesView: View {

    @StateObject private var appNavigation = AppNavigation()
    @ObservedObject var viewModel = CountriesViewModel()
   
    @State var selectedCountry = ""
    func isCountryChosen(countryName: String) -> Binding<Bool> {
        return Binding<Bool> {
            
            print("selected country:\(selectedCountry), country: \(countryName)")
            return selectedCountry == countryName
        } set: { value in
            selectedCountry = value ? countryName : ""
            print("New value: \(value) for country: \(countryName)")
        }
    }
    

    
    var body: some View {
        NavigationView {
            List(viewModel.countries) { country in
                NavigationLink(country.name, isActive: isCountryChosen(countryName: country.name)) {
                    CountryView(country: country)
                }
            }
        }
        //.navigationViewStyle(.stack)
        .onAppear {
            viewModel.load()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
    }
}
