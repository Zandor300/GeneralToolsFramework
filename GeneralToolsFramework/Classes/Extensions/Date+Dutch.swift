//
//  Date+Dutch.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 24/04/2019.
//

import Foundation

public extension Date {

    var dutchDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: self)
    }

    var dutchDateTimeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH::mm::ss"
        return formatter.string(from: self)
    }

}
