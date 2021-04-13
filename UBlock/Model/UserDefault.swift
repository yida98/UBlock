//
//  UserDefault.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-07.
//

import Foundation
import AppKit

@propertyWrapper
struct UserDefault<Value: Codable> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.setValue(newValue, forKey: key)
        }
    }
}

extension UserDefaults {
    
    @UserDefault(key: UserDefaults.Keys.appCategories.rawValue, defaultValue: [AppCategory]())
    static var appCategories: [AppCategory]
    
    @UserDefault(key: UserDefaults.Keys.rules.rawValue, defaultValue: [Rule]())
    static var rules: [Rule]
    
    @UserDefault(key: UserDefaults.Keys.apps.rawValue, defaultValue: AlphabetizedList<AppFile>())
    static var apps: AlphabetizedList<AppFile>
    
    enum Keys: String {
        case appCategories = "appCategories"
        case rules = "rules"
        case apps = "apps"
    }
}
