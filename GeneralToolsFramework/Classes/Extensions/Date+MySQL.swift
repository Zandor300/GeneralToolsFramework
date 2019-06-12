//
//  Date+MySQL.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 04/01/2019.
//

import Foundation

public extension Date {

    /// Convert MySQL/MariaDB Date object as a String to a Swift Date object. Returns Date() if string is invalid.
    init(mysqlDate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: mysqlDate) {
            self = date
        } else {
            self = Date()
        }
    }

    /// Convert MySQL/MariaDB DateTime object as a String to a Swift Date object. Returns Date() if string is invalid.
    init(mysqlDateTime: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: mysqlDateTime) {
            self = date
        } else {
            self = Date()
        }
    }

    /// Convert MS SQL Server DateTime object as a String to a Swift Date object. Returns Date() if string is invalid.
    init(mssqlDateTime: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        if let date = dateFormatter.date(from: mssqlDateTime) {
            self = date
        } else {
            self = Date()
        }
    }

    var mysqlDateString: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)

        let year = String(components.year!)
        var month = String(components.month!)
        var day = String(components.day!)

        if month.count < 2 {
            month = "0" + month
        }
        if day.count < 2 {
            day = "0" + day
        }

        return year + "-" + month + "-" + day
    }

    var mysqlDateTimeString: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)

        let year = String(components.year!)
        var month = String(components.month!)
        var day = String(components.day!)
        var hour = String(components.hour!)
        var minute = String(components.minute!)
        var second = String(components.second!)

        if month.count < 2 {
            month = "0" + month
        }
        if day.count < 2 {
            day = "0" + day
        }
        if hour.count < 2 {
            hour = "0" + hour
        }
        if minute.count < 2 {
            minute = "0" + minute
        }
        if second.count < 2 {
            second = "0" + second
        }

        return year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second
    }

}
