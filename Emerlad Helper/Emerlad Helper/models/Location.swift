//
//  Location.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/9/24.
//



import Foundation

import GooglePlaces
import UIKit
import SwiftUI


class Location{
    
    
    
    private var name: String?
    private var address: String?
    
    private lazy var placesClient = GMSPlacesClient.shared()
    
    init() {
        self.name = nil
        self.address = nil
    }
    
    
    var namePublic: String?{
        get{
            return self.name
        }
        set{
            self.name = newValue
        }
    }
    
    var addressPublic: String?{
        get{
            return self.address
        }
        set{
            self.address = newValue
        }
    }
    
    
    func searchPlaces(query: String, completion: @escaping ([GMSPlace]?, Error?) -> Void) {
            let filter = GMSAutocompleteFilter()
        filter.type = .address// Customize this based on the type of places you're interested in
            
        placesClient.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: nil) { (results, error) in
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                guard let results = results else {
                    completion(nil, nil)
                    return
                }
                
                // Convert prediction results to GMSPlace objects
                var places: [GMSPlace] = []
                let group = DispatchGroup()
                
                for result in results {
                    group.enter()
                    self.placesClient.fetchPlace(fromPlaceID: result.placeID, placeFields: .all, sessionToken: nil) { (place, error) in
                        if let place = place {
                            places.append(place)
                        }
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    completion(places, nil)
                }
            }
        }
    
    
    
    
    
}


