//
//  TravelTimeCalculationService.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 13/12/2023.
//

import Foundation
import MapKit

enum TravelTimeCalculationResult {
    case success(travelDuration: TimeInterval?)
    case failure(error: Error)
}

struct TravelTimeCalculationService {
    
    func calculateTravelTime(from sourceLocation: CLLocationCoordinate2D,
                             to destinationLocation: CLLocationCoordinate2D) async throws -> TimeInterval? {
        
        try await withCheckedThrowingContinuation { continuation in
            self.calculateTravelTime(from: sourceLocation, to: destinationLocation, completion: { timeInterval, error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: timeInterval)
                }
            })
        }
    }
    
    private func calculateTravelTime(from sourceLocation: CLLocationCoordinate2D,
                                     to destinationLocation: CLLocationCoordinate2D,
                                     completion: @escaping (TimeInterval?, Error?) -> Void) {
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let request = MKDirections.Request()
        request.source = sourceMapItem
        request.destination = destinationMapItem
        request.transportType = .automobile // You can change this to .walking or .transit
        
        let directions = MKDirections(request: request)
        
        directions.calculate { (response, error) in
            guard let route = response?.routes.first else {
                completion(nil, error)
                return
            }
            
            let travelTime = route.expectedTravelTime
            completion(travelTime, nil)
        }
    }
    
    func calculateTravelTime(from sourceLocations: [CLLocationCoordinate2D],
                             to destinationLocation: CLLocationCoordinate2D) async -> [TravelTimeCalculationResult] {
        
        await withCheckedContinuation { continuation in
            self.calculateTravelTime(from: sourceLocations, to: destinationLocation) { results in
                continuation.resume(returning: results)
            }
        }
    }
    
    private func calculateTravelTime(from sourceLocations: [CLLocationCoordinate2D],
                                     to destinationLocation: CLLocationCoordinate2D,
                                     completion: @escaping ([TravelTimeCalculationResult]) -> Void) {
        var results = [TravelTimeCalculationResult]()
        for sourceLocation in sourceLocations {
            
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
            let destinationPlacemark = MKPlacemark(coordinate: destinationLocation)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let request = MKDirections.Request()
            request.source = sourceMapItem
            request.destination = destinationMapItem
            request.transportType = .automobile // You can change this to .walking or .transit
            
            let directions = MKDirections(request: request)
            
            NSLog("--- Will calulate travel time")
            directions.calculate { (response, error) in
                let result = Self.makeTravelTimeCalculationResult(response: response, error: error)
                DispatchQueue.main.async {
                    NSLog("--- Did calulate travel time")
                    results.append(result)
                    if results.count == sourceLocations.count {
                        completion(results)
                    }
                }
            }
        }
    }
    
    static func makeTravelTimeCalculationResult(response: MKDirections.Response?, error: Error?) -> TravelTimeCalculationResult {
       
        if let error {
            return .failure(error: error)
        }
        
        let travelDuration = response?.routes.first?.expectedTravelTime
        return .success(travelDuration: travelDuration)
    }
    
}
