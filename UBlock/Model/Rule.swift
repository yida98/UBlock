//
//  Rule.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import Foundation

class Rule: Identifiable, ObservableObject, Codable {
    private var category: AppCategory
    private var weekday: [DayOptions]
    private var start: Time
    private var end: Time
    var id: UUID
    
    init(category: AppCategory, weekday: [DayOptions], start: Time, end: Time) {
        self.category = category
        self.weekday = weekday
        self.start = start
        self.end = end
        self.id = UUID()
    }
    
}

extension Rule {
    func description() -> String {
        return "No \(category.name) \(weekdayString()) from \(start.description()) to \(end.description())"
    }
    
    private func weekdayString() -> String {
        let days: [String] = weekday.compactMap { DayOptions.strDict[$0] }
        let result = "every "
        
        if days.count == 1 {
            if days[0] == DayOptions.strDict[.everyday] {
                return days[0].lowercased()
            }
            return "\(result)\(days[0])"
        } else {
            return "\(result)\(days.joined(separator: ", "))"
        }
    }
}

struct DayOptions: OptionSet, Codable {
    let rawValue: Int
}

extension DayOptions {
    static let mon  = DayOptions(rawValue: 1 << 0)
    static let tues = DayOptions(rawValue: 1 << 1)
    static let wed  = DayOptions(rawValue: 1 << 2)
    static let thur = DayOptions(rawValue: 1 << 3)
    static let fri  = DayOptions(rawValue: 1 << 4)
    static let sat  = DayOptions(rawValue: 1 << 5)
    static let sun  = DayOptions(rawValue: 1 << 6)
    
    static let weekday: DayOptions = [.mon, .tues, .wed, .thur, .fri]
    static let weekend: DayOptions = [.sat, .sun]
    static let everyday: DayOptions = [.weekday, .weekend]
}

extension DayOptions: Hashable {
    static let strDict: [DayOptions: String] = [.mon: "Monday",
                                                .tues: "Tuesday",
                                                .wed: "Wednesday",
                                                .thur: "Thursday",
                                                .fri: "Friday",
                                                .sat: "Saturday",
                                                .sun: "Sunday",
                                                .weekday: "Weekday",
                                                .weekend: "Weekend",
                                                .everyday: "Everyday"]
}
