//
//  UserSettings.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-10.
//

import Foundation
import Combine

final class UserSettings: ObservableObject {
    let objectWillChange: PassthroughSubject = PassthroughSubject<Void, Never>()
    
    @UserDefault(key: .appCategories, defaultValue: [AppCategory]())
    static var appCategories: [AppCategory] {
        willSet {
            
        }
    }
    
    @UserDefault(key: .rules, defaultValue: [Rule]())
    static var rules: [Rule]
}
