//
//  Date+Ago.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 24/04/2019.
//

import Foundation

public class DateIntervalTranslation {

    public static let english: DateIntervalTranslation = {
        let translation = DateIntervalTranslation()
        translation.yearSingle = "year"
        translation.yearMultiple = "years"
        translation.monthSingle = "month"
        translation.monthMultiple = "months"
        translation.daySingle = "day"
        translation.dayMultiple = "days"
        translation.hourSingle = "hour"
        translation.hourMultiple = "hours"
        translation.minuteSingle = "minute"
        translation.minuteMultiple = "minutes"
        translation.moment = "a moment"
        translation.ago = "ago"
        return translation
    }()
    public static let dutch: DateIntervalTranslation = {
        let translation = DateIntervalTranslation()
        translation.yearSingle = "jaar"
        translation.yearMultiple = "jaar"
        translation.monthSingle = "maand"
        translation.monthMultiple = "maanden"
        translation.daySingle = "dag"
        translation.dayMultiple = "dagen"
        translation.hourSingle = "uur"
        translation.hourMultiple = "uur"
        translation.minuteSingle = "minuut"
        translation.minuteMultiple = "minuten"
        translation.moment = "een moment"
        translation.ago = "geleden"
        return translation
    }()

    var yearSingle: String = String()
    var yearMultiple: String = String()
    var monthSingle: String = String()
    var monthMultiple: String = String()
    var daySingle: String = String()
    var dayMultiple: String = String()
    var hourSingle: String = String()
    var hourMultiple: String = String()
    var minuteSingle: String = String()
    var minuteMultiple: String = String()
    var moment: String = String()
    var ago: String = String()

}

public extension Date {

    func getElapsedInterval(translation: DateIntervalTranslation = .english, ago: Bool = true) -> String {
        let now = Date()
        var interval = Calendar.current.dateComponents([.year], from: self, to: now).year

        if let interval = interval, interval > 0 {
            return String(interval) + " " + (interval == 1 ? translation.yearSingle : translation.yearMultiple) + (ago ? " " + translation.ago : "")
        }

        interval = Calendar.current.dateComponents([.month], from: self, to: now).month
        if let interval = interval, interval > 0 {
            return String(interval) + " " + (interval == 1 ? translation.monthSingle : translation.monthMultiple) + (ago ? " " + translation.ago : "")
        }

        interval = Calendar.current.dateComponents([.day], from: self, to: now).day
        if let interval = interval, interval > 0 {
            return String(interval) + " " + (interval == 1 ? translation.daySingle : translation.dayMultiple) + (ago ? " " + translation.ago : "")
        }

        interval = Calendar.current.dateComponents([.hour], from: self, to: now).hour
        if let interval = interval, interval > 0 {
            return String(interval) + " " + (interval == 1 ? translation.hourSingle : translation.hourMultiple) + (ago ? " " + translation.ago : "")
        }

        interval = Calendar.current.dateComponents([.minute], from: self, to: now).minute
        if let interval = interval {
            if interval > 0 {
                return String(interval) + " " + (interval == 1 ? translation.minuteSingle : translation.minuteMultiple) + (ago ? " " + translation.ago : "")
            }
        } else {
            return "error"
        }

        return translation.moment + (ago ? " " + translation.ago : "")
    }

}
