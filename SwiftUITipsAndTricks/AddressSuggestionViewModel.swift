//
//  AddressSuggestionViewModel.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 13/12/2023.
//

import Foundation
import Combine
import SwiftUI
import MapKit

final class AddressSuggestion: ObservableObject {
    @Published var townCandidate = ""
    @Published var selectedTownLocation: Location?
    
    @Published var streetCandidate = ""
    @Published var selectedStreetLocation: Location?
    
    @Published var coordinate: CLLocationCoordinate2D?
    @Published var coordinateText: String = ""
}

final class AddressSuggestionViewModel: ObservableObject {
    
    @Binding var addressSuggestion: AddressSuggestion
    @Published var locations = Locations()
    private var cancellables = Set<AnyCancellable>()
    private var addressGeocodingService = AddressGeocodingService()
    private var locationService = LocationCompleterService()
    
    init(addressSuggestion: Binding<AddressSuggestion>) {
        self._addressSuggestion = addressSuggestion
        [townLocationsPublisher, streetLocationsPublisher].forEach{ publisher in
            publisher
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { _ in
                    
                }, receiveValue: { [weak self] locations in
                    self?.locations = locations
                })
                .store(in: &cancellables)
        }
        
        self.addressSuggestion.$selectedStreetLocation
        .compactMap { $0 }
        .flatMap { [weak self] location in
            self!.addressGeocodingService.geocode(address: location.friendlyName)
        }
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { _ in
            
        }, receiveValue: { [weak self] placemark in
            if let coordinate = placemark.location?.coordinate {
                self!.addressSuggestion.coordinate = coordinate
                self!.addressSuggestion.coordinateText = "\(coordinate.latitude), \(coordinate.longitude)"
                self!.objectWillChange.send()
            }
        })
        .store(in: &cancellables)
    }
    
    private var townLocationsPublisher: AnyPublisher<Locations, Error> {
        addressSuggestion.$townCandidate.locationPublisher { [weak self] townCandidate in
            self!.locationService.searchForLocations(withQuery: townCandidate)
        }
    }
    
    private var streetLocationsPublisher: AnyPublisher<Locations, Error> {
        addressSuggestion.$streetCandidate.locationPublisher{ [weak self] streetCandidate in
            let townName: String
            if let townLocation = self?.addressSuggestion.selectedTownLocation {
                townName = townLocation.title
            } else {
                townName = ""
            }
            let locationCandidate = "\(townName), \(streetCandidate)"
            NSLog("Query: \(locationCandidate)")
            return self!.locationService.searchForLocations(withQuery: locationCandidate, resultType: .address)
        }
    }
    
    func onTownLocationSelected(_ location: Location) {
        addressSuggestion.selectedTownLocation = location
        objectWillChange.send()
    }
    
    func onStreetLocationSelected(_ location: Location) {
        addressSuggestion.selectedStreetLocation = location
        objectWillChange.send()
    }
}
