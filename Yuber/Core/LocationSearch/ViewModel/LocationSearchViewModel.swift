//
//  LocationSearchViewModel.swift
//  Yuber
//
//  Created by Honnier on 6/11/23.
//

import Foundation
import MapKit

class LocationSearchViewModel : NSObject, ObservableObject{
    
    //MARK: - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedRideLocation : RideLocation?
    @Published var pickupTime : String?
    @Published var dropoffTime : String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment = "" {
        didSet {
            print("DEBBUG: QUERY \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    var userLocation : CLLocationCoordinate2D?
    
    //MARK: - LifeCicle
    override init(){
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    //MARK: - Helpers
    func selectLocation(_ localSearch: MKLocalSearchCompletion){
        locationSearch(forLocalSearchCompletion: localSearch, completion: { response, error in
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedRideLocation = RideLocation(title: localSearch.title, coordinate: coordinate)
        })
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    func computeRideType(forType type: RideType) -> Double {
        guard let coordinate = selectedRideLocation?.coordinate else { return 0.0 }
        guard let userLocation = self.userLocation else {
            return 0.0
        }
        
        let currentUserLocation = CLLocation(latitude: userLocation.latitude,longitude: userLocation.longitude)
        let destination = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let tripDistanceInMeters = currentUserLocation.distance(from: destination)
        return type.computedPrice(for: tripDistanceInMeters)
    }
    
    func getDestinationRoute(from userLocation:CLLocationCoordinate2D, to destination:CLLocationCoordinate2D , completion: @escaping(MKRoute) -> Void ){
        let userPlacemarket = MKPlacemark(coordinate: userLocation)
        let destPlacemarket = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemarket)
        request.destination = MKMapItem(placemark: destPlacemarket)
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let error = error {
                print("DEBBUG: Failed to get directions \(error)")
                return
            }
            guard let route = response?.routes.first else { return }
            self.configureDropoffAndPickupTime(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configureDropoffAndPickupTime(with expectedTravelTime: Double){
        let formater = DateFormatter()
        formater.dateFormat = "hh:mm a"
        
        pickupTime = formater.string(from: Date())
        dropoffTime = formater.string(from: Date() + expectedTravelTime)
    }
}

   //MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
