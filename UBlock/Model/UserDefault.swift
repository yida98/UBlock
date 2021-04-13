//
//  UserDefault.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-07.
//

import Foundation
import AppKit

@propertyWrapper
struct UserDefault<Value> {
    let key: UserDefault.Keys
    let defaultValue: Value
    var container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
            return container.object(forKey: key.rawValue) as? Value ?? defaultValue
        }
        set {
            container.setValue(newValue, forKey: key.rawValue)
        }
    }
    enum Keys: String {
        case appCategories
        case rules
        case apps
    }
}

extension UserDefaults {
    
    @UserDefault(key: .appCategories, defaultValue: [AppCategory]())
    static var appCategories: [AppCategory]
    
    @UserDefault(key: .rules, defaultValue: [Rule]())
    static var rules: [Rule]
    
    @UserDefault(key: .apps, defaultValue: AlphabetizedList<AppFile>())
    static var apps: AlphabetizedList<AppFile>
}
