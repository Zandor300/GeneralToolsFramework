//
//  Date+MySQL.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 04/01/2019.
//

import Foundation

public extension Date {
    
    /// Convert MySQL/MariaDB Date object as a String to a Swift Date object. Returns Date() if string is invalid.
    public init(mysqlDate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: mysqlDate) {
            self = date
        } else {
            self = Date()
        }
    }
    
    /// Convert MySQL/MariaDB DateTime object as a String to a Swift Date object. Returns Date() if string is invalid.
    public init(mysqlDateTime: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: mysqlDateTime) {
            self = date
        } else {
            self = Date()
        }
    }
    
}
