//
//  RideType.swift
//  Yuber
//
//  Created by Honnier on 6/11/23.
//

import Foundation

enum RideType : Int, Identifiable,CaseIterable{
    var id: Int { return rawValue }
    
    case uberX
    case black
    case uberXl
    
    var description: String {
        switch self {
        case .uberX:
            return "UberX"
        case .black:
            return "Black"
        case .uberXl:
            return "UberXL"
        }
    }
    
    var imageName: String {
        switch self {
        case .uberX:
            return "uber-1"
        case .black:
            return "uber-3"
        case .uberXl:
            return "uber-1"
        }
    }
    
    var baseFare : Double {
        switch self {
        case .uberX:
            return 5
        case .black:
            return 20
        case .uberXl:
            return 10
        }
    }
    
    
    func computedPrice(for distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters / 1600
        
        switch self {
        case .uberX:
            return distanceInMiles * 1.5 + baseFare
        case .black:
            return distanceInMiles * 2 + baseFare
        case .uberXl:
            return distanceInMiles * 1.75 + baseFare
        }
    }
    
    
}
