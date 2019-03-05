//
//  Double+Round.swift
//  Connectivity
//
//  Created by Zandor Smith on 07/02/2019.
//

import Foundation

extension Double {

    public func roundToPlaces(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

}
