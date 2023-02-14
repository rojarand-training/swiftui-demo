//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

extension Sequence {
    func sorted<Property: Comparable>(by keyPath: KeyPath<Element, Property>,
                                      comparator: (Property, Property) -> Bool = (<)) -> [Element] {
        self.sorted { element1, element2 in
            comparator(element1[keyPath: keyPath], element2[keyPath: keyPath])
        }
    }
}

class Country: NSObject {
    let name: String
    @objc let areaInSquareKm: Double
    let citiesOver1M: Int
    
    init(name: String,
         areaInSquareKm: Double,
         citiesOver1M: Int) {
        self.name = name
        self.areaInSquareKm = areaInSquareKm
        self.citiesOver1M = citiesOver1M
    }
}

final class ContentViewModel: ObservableObject {
    @Published var countries: [Country] = [
        Country(name: "Poland", areaInSquareKm: 312000, citiesOver1M: 1),
        Country(name: "Lithuania", areaInSquareKm: 65000, citiesOver1M: 0),
        Country(name: "Germany", areaInSquareKm: 357000, citiesOver1M: 4),
        Country(name: "France", areaInSquareKm: 551000, citiesOver1M: 1),
        Country(name: "Russia", areaInSquareKm: 17100000, citiesOver1M: 16),
        Country(name: "Czechia", areaInSquareKm: 78000, citiesOver1M: 1),
    ]
}

struct CountrySorting {
    typealias Strategy = (Country, Country) -> Bool
    let strategy: Strategy
}

extension CountrySorting {
    static var citiesOver1M: CountrySorting {
        CountrySorting(strategy: { country1, country2 in
            country1.citiesOver1M < country2.citiesOver1M
        })
    }
}

extension ContentViewModel {
    func sort<Property: Comparable>(by property: KeyPath<Country, Property>,
                                    comparator: (Property, Property) -> Bool = (<)) {
        countries = countries.sorted(by: property, comparator: comparator)
    }
    
    func sort(by sorting: CountrySorting) {
        countries = countries.sorted(by: sorting.strategy)
    }
    
    func sortByAreaDesc() {
        countries = countries.sorted(using: SortDescriptor(\Country.areaInSquareKm, order: .reverse))
    }
    
    func sortByAreaAsc() {
        countries = countries.sorted(using: SortDescriptor(\Country.areaInSquareKm, order: .forward))
    }
}

//-------

extension Country: Comparable {
    static func < (lhs: Country, rhs: Country) -> Bool {
        lhs.name < rhs.name
    }
}

extension ContentViewModel {
    func sortByDefault() {
        countries = countries.sorted()
    }
}

//-------

struct ContentView: View {
    @ObservedObject var vm = ContentViewModel()
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                Button {
                    vm.sort(by: \.name, comparator: <)
                } label: {
                    VStack {
                        Image(systemName: "cellularbars")
                        Text("Name ASC").font(.caption2)
                    }
                }
                Button {
                    vm.sort(by: \.name, comparator: >)
                } label: {
                    VStack {
                        Image(systemName: "cellularbars")
                        Text("Name DESC").font(.caption2)
                    }
                }
                Button {
                    vm.sortByAreaAsc()
                } label: {
                    VStack {
                        Image(systemName: "cellularbars")
                        Text("Area ASC").font(.caption2)
                    }
                }
                Button {
                    vm.sortByAreaDesc()
                } label: {
                    VStack {
                        Image(systemName: "cellularbars")
                        Text("Area DESC").font(.caption2)
                    }
                }
                Button {
                    vm.sort(by: .citiesOver1M)
                } label: {
                    VStack {
                        Image(systemName: "cellularbars")
                        Text("Big cities").font(.caption2)
                    }
                }
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
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
