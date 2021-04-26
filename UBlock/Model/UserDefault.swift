//
//  UserDefault.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-07.
//

import Foundation
import AppKit
import Combine

@propertyWrapper
struct UserDefault<Value: Codable> {
    let key: UserDefault.Keys
    let defaultValue: Value
    var container: UserDefaults = .standard
    
    init(_ key: UserDefault.Keys, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: Value {
        get {
            let obj = container.object(forKey: key.rawValue)
            if let valueObj = obj as? Value {
                return valueObj
            } else if let dataObj = obj as? Data {
                do {
                    return try JSONDecoder().decode(Value.self, from: dataObj)
                } catch {
                    debugPrint("\(error) \(defaultValue)")
                }
            }
            return defaultValue
        }
        set {
            if let _ = newValue as? PropertyListValue {
                container.setValue(newValue, forKey: key.rawValue)
            } else {
                let jsonData = try! JSONEncoder().encode(newValue)
                container.setValue(jsonData, forKey: key.rawValue)
            }
        }
    }
    
    enum Keys: String {
        case appCategories = "appCategories"
        case appCategoryNames = "appCategoryNames"
        case rules = "rules"
        case apps = "apps"
        case urls = "urls"
    }
}

final class Storage: ObservableObject {
    
    static let shared = Storage()
    
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    @UserDefault(.appCategories, defaultValue: AlphabetizedList<AppCategory>())
    var appCategories: AlphabetizedList<AppCategory> {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault(.appCategoryNames, defaultValue: Set<String>())
    var appCategoryNames: Set<String> {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault(.rules, defaultValue: [Rule]())
    var rules: [Rule] {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault(.apps, defaultValue: AlphabetizedList<AppFile>())
    var apps: AlphabetizedList<AppFile> {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault(.urls, defaultValue: Dictionary<URL, AppFile>())
    var urls: Dictionary<URL, AppFile> {
        willSet {
            objectWillChange.send()
        }
    }
    
    static func insert(_ category: AppCategory) {
        Storage.shared.appCategories.insert(category)
        Storage.shared.appCategoryNames.insert(category.name)
    }
    
    static func removeAppCategory(_ category: AppCategory) {
        Storage.shared.appCategories.remove(category)
        Storage.shared.appCategoryNames.remove(category.name)
    }
    
}

protocol PropertyListValue {}

extension Data: PropertyListValue {}
extension String: PropertyListValue {}
extension Date: PropertyListValue {}
extension Bool: PropertyListValue {}
extension Int: PropertyListValue {}
extension Double: PropertyListValue {}
extension Float: PropertyListValue {}

// Every element must be a property-list type
extension Array: PropertyListValue where Element: PropertyListValue {}
extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}
