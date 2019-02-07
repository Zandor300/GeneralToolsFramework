//
//  Float+Round.swift
//  Connectivity
//
//  Created by Zandor Smith on 07/02/2019.
//

import Foundation

extension Float {
    
    public func roundToPlaces(_ places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
    
}
