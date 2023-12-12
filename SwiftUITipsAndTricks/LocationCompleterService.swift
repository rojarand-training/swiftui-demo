//
//  LocationCompleterService.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 14/12/2023.
//

import Foundation
import Combine
import MapKit

final class LocationCompleterService: NSObject, MKLocalSearchCompleterDelegate {
    
    let completer = MKLocalSearchCompleter()
    var searchResults: [MKLocalSearchCompletion] = []
    private var premise: ((Result<Locations, Error>) -> Void)?
    
    override init() {
        super.init()
        completer.resultTypes = .address
        completer.region = Self.Poland
        completer.delegate = self
    }
    
    private static var Poland: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.9, longitude: 19.2),
                           latitudinalMeters: 500000,
                           longitudinalMeters: 450000)
    }
    
    func searchForLocations(withQuery query: String, resultType: MKLocalSearchCompleter.ResultType = .address) -> Future<Locations, Error> {
        let future = Future { [weak self] premise in
            self?.premise = premise
        }
//        completer.resultTypes = resultType
        completer.queryFragment = query
        return future
    }
    
    // MARK: - MKLocalSearchCompleterDelegate
    
    public func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.premise?(.success(completer.results))
    }
    
    public func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        self.premise?(.failure(error))
    }
}
