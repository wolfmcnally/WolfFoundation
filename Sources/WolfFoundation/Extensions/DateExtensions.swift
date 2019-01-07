//
//  DateExtensions.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 7/12/15.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

extension Calendar {
    /// Returns the last day of the month containing `date`. So if the date is in a January, this method will return January 31.
    public func lastDayOfMonth(for date: Date) -> Date {
        let dayRange = range(of: .day, in: .month, for: date)!
        let dayCount = dayRange.count
        var comp = dateComponents([.year, .month, .day], from: date)
        comp.day = dayCount
        return self.date(from: comp)!
    }

    /// Returns the year of `date`.
    public func year(of date: Date) -> Int {
        return dateComponents([.year], from: date).year!
    }

    /// Returns the day of the week of `date`. So if `date` falls on a Monday, this method will return 2.
    public func weekday(of date: Date) -> Int {
        return dateComponents([.weekday], from: date).weekday!
    }

    /// Returns the ordinality of the day of `date`, taking into account `self`'s firstWeekday setting.
    public func dayInWeek(of date: Date) -> Int {
        return ordinality(of: .weekday, in: .weekOfYear, for: date)!
    }

    /// Returns the date of the first day of the week containing `date`. So if `date` falls on a Tuesday and the user has set the calendar week to start on Sunday, the date returned will be at the start of that Sunday, two days back. If `date` falls on that same Tuesday and the user has set the calendar week to start on Monday, the date returned will be the start of that Monday, one day back.
    public func firstDayOfWeek(for date: Date) -> Date {
        var d = startOfDay(for: date)
        while weekday(of: d) != firstWeekday {
            d = self.date(byAdding: .day, value: -1, to: d)!
        }
        return d
    }

    /// Returns the date 24 hours after `date`.
    public func nextDay(after date: Date) -> Date {
        return self.date(byAdding: .day, value: 1, to: date)!
    }
}


// Provide for converting dates to and from ISO8601 format.
// Example: "1965-05-15T00:00:00.0Z"
extension Date {
    public static var iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sZ"
        return formatter
    }()

    public var iso8601: String {
        return type(of: self).iso8601Formatter.string(from: self)
    }

    public static var shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    public var shortFormat: String {
        return type(of: self).shortDateFormatter.string(from: self)
    }
}

extension String {
    func padded(to count: Int, onRight: Bool = false, with character: Character = " ") -> String {
        let startCount = self.count
        let padCount = count - startCount
        guard padCount > 0 else { return self }
        let pad = String(repeating: String(character), count: padCount)
        return onRight ? (self + pad) : (pad + self)
    }

    static func padded(to count: Int, onRight: Bool = false, with character: Character = " ") -> (String) -> String {
        return { $0.padded(to: count, onRight: onRight, with: character) }
    }

    func paddedWithZeros(to count: Int) -> String {
        return padded(to: count, onRight: false, with: "0")
    }

    static func paddedWithZeros(to count: Int) -> (String) -> String {
        return { $0.paddedWithZeros(to: count) }
    }
}

extension Date {
    public init(iso8601: String) throws {
        if let date = type(of: self).iso8601Formatter.date(from: iso8601) {
            let timeInterval = date.timeIntervalSinceReferenceDate
            self.init(timeIntervalSinceReferenceDate: timeInterval)
        } else {
            throw WolfFoundationError("Invalid ISO8601 format")
        }
    }

    public init(year: Int, month: Int, day: Int) throws {
        guard year > 0 else {
            throw WolfFoundationError("Invalid year")
        }
        guard 1...12 ~= month else {
            throw WolfFoundationError("Invalid month")
        }
        guard 1...31 ~= day else {
            throw WolfFoundationError("Invalid day")
        }
        let yearString = String(year)
        let monthString = String(month).paddedWithZeros(to: 2)
        let dayString = String(day).paddedWithZeros(to: 2)
        try self.init(iso8601: "\(yearString)-\(monthString)-\(dayString)T00:00:00.0Z")
    }
}

extension Date {
    public init(millisecondsSince1970 ms: Double) {
        self.init(timeIntervalSince1970: ms / 1000.0)
    }

    public var millisecondsSince1970: Double {
        return timeIntervalSince1970 * 1000.0
    }
}

extension Date {
    public var julianMoment: Double {
        let secondsPerDay =  86400.0  // 24 * 60 * 60
        let gregorian20010101 = 2451910.5 // Julian date of 00:00 UT on 1st Jan 2001 which is NSDate's reference date.
        return self.timeIntervalSinceReferenceDate / secondsPerDay + gregorian20010101
    }

    public var julianDay: Int {
        let julianDayNumber = Int(round(julianMoment))
        return julianDayNumber
    }
}

extension Date {
    public init?(naturalLanguage s: String) {
        let type: NSTextCheckingResult.CheckingType = .date
        let detector = try! NSDataDetector(types: type.rawValue)
        let length = (s as NSString).length
        let range = NSRange(location: 0, length: length)
        guard let match = detector.firstMatch(in: s, options: .reportCompletion, range: range) else {
            return nil
        }
        guard match.range == range else { return nil }
        guard match.resultType == type else { return nil }
        if let date = match.date {
            self.init(timeIntervalSince1970: date.timeIntervalSince1970)
        } else {
            return nil
        }
    }
}

public func addSeconds(_ s: TimeInterval) -> (_ date: Date) -> Date {
    return { date in
        return date.addingTimeInterval(s)
    }
}

public func addMinutes(_ m: Double) -> (_ date: Date) -> Date {
    return { date in
        return date.addingTimeInterval(oneMinute * m)
    }
}

public func addHours(_ h: Double) -> (_ date: Date) -> Date {
    return { date in
        return date.addingTimeInterval(oneHour * h)
    }
}

public func addDays(_ d: Double) -> (_ date: Date) -> Date {
    return { date in
        return date.addingTimeInterval(oneDay * d)
    }
}
