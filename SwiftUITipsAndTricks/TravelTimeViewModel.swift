//
//  TravelTimeViewModel.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 12/12/2023.
//

import Combine
import MapKit

typealias Location = MKLocalSearchCompletion
typealias Locations = [Location]

extension Location {
    var friendlyName: String {
        title + ", " + subtitle
    }
}

extension Location: Identifiable {
    public var id: String { friendlyName }
}

extension Published<String>.Publisher {
    func locationPublisher(locationsService: @escaping (String) -> Future<Locations, Error>) -> AnyPublisher<Locations, Error> {
        debounce(for: .seconds(0.6), scheduler: RunLoop.current)
        .filter { $0.count >= 3 }
        .removeDuplicates()
        .flatMap { locationCandidate in
            locationsService(locationCandidate)
        }
        .eraseToAnyPublisher()
    }
}

final class TravelTimeViewModel: ObservableObject {
    
    var startAddressSuggestion = AddressSuggestion()
    var finishAddressSuggestion = AddressSuggestion()
    
    @Published var locations = Locations()
    private var locationService = LocationCompleterService()
    private var addressGeocodingService = AddressGeocodingService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var travelTime: String = ""
    @Published var isComputingTravelTimeAvailable = false
    
    @Published var latitude: String = ""
    @Published var longitude: String = ""
    @Published var reverseGeocodedAddress: String = ""
    
    init() {
        isCalculatingTravelTimeAvailablePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isComputingTravelTimeAvailable, on: self)
            .store(in: &cancellables)
    }
    
    @MainActor
    func reverseGeocodeAddress() {
        guard let lat = CLLocationDegrees(latitude), let lon = CLLocationDegrees(longitude) else { return }
        let coordinates = CLLocation(latitude: lat, longitude: lon)
        Task {
            do {
                let placemarks = try await addressGeocodingService.reverseGeocode(location: coordinates)
                if let placemark = placemarks.first {
                    self.reverseGeocodedAddress = "\(placemark.locality ?? ""), \(placemark.subLocality ?? ""), \(placemark.name ?? ""), \(placemark.thoroughfare ?? ""), \(placemark.subThoroughfare ?? "")"
                }
                
            } catch {
            }
        }
    }
    
    @MainActor
    func computeTravelTime() {
        guard let startCoordinate = self.startAddressSuggestion.coordinate,
                let finishCoordinate = self.finishAddressSuggestion.coordinate else { return }
        Task {
            do {
                if let timeInterval = try await TravelTimeCalculationService().calculateTravelTime(from: startCoordinate, to: finishCoordinate) {
                    self.travelTime = Self.toHumanDuration(interval: timeInterval)
                }
            } catch {
            }
        }
    }
    
    @MainActor
    func computeMultipleTravelTime() {
        
        let startCoordinates: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 53.138445, longitude: 23.120686), //Białystok, Wierzbowa, Hotel Turkus/Myjnia
        CLLocationCoordinate2D(latitude: 53.140074, longitude: 23.140227), //Białystok, Wiatrakowa
        CLLocationCoordinate2D(latitude: 53.133456, longitude: 23.151473), //Białystok, róg Grochowej i Lipowej
        CLLocationCoordinate2D(latitude: 53.129468, longitude: 23.157557), //Białystok, szkoła językowa English expert
        CLLocationCoordinate2D(latitude: 53.148887, longitude: 23.220178), //Białystok, Bagnówka, Karola Białkowskiego
        CLLocationCoordinate2D(latitude: 53.125756, longitude: 23.258890), //Grabówka, Białostocka
        ]
        let finishCoordinate: CLLocationCoordinate2D =
            CLLocationCoordinate2D(latitude:53.118968, longitude: 23.102442)//Białystok, Zielonogórska 36
        
        Task {
            let result = await TravelTimeCalculationService().calculateTravelTime(from: startCoordinates, to: finishCoordinate)
            print(result)
        }
    }
    
    
    private var isCalculatingTravelTimeAvailablePublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(startAddressSuggestion.$coordinate, finishAddressSuggestion.$coordinate)
            .map{ ($0 != nil) && ($1 != nil) }
            .eraseToAnyPublisher()
    }
    
    private static func toHumanDuration(interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        return formatter.string(from: TimeInterval(interval))!
    }
}

struct AddressGeocodingService {
    
    private let geocoder = CLGeocoder()
    private var premise: ((Result<CLPlacemark, Error>) -> Void)?
    
    func geocode(address: String) -> Future<CLPlacemark, Error> {
        Future { premise in
            geocoder.geocodeAddressString(address) { (placemarks, error) in
                if let error {
                    premise(.failure(error))
                } else {
                    premise(.success(placemarks!.first!))
                }
            }
        }
    }
    
    func reverseGeocode(location: CLLocation) -> Future<[CLPlacemark], Error> {
        Future { premise in
            geocoder.reverseGeocodeLocation(location) { (placemarks: [CLPlacemark]?, error: Error?) in
                if let error {
                    premise(.failure(error))
                } else {
                    premise(.success(placemarks ?? []))
                }
            }
        }
    }
    
    func reverseGeocode(location: CLLocation) async throws -> [CLPlacemark] {
        
        try await withCheckedThrowingContinuation { continuation in
            geocoder.reverseGeocodeLocation(location) { (placemarks: [CLPlacemark]?, error: Error?) in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: placemarks ?? [])
                }
            }
        }
    }
}

