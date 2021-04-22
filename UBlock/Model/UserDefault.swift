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
            if let rtnObj = obj as? Value {
                return rtnObj
            } else {
                do {
                    if let dataObj = obj as? Data {
                        return try JSONDecoder().decode(Value.self, from: dataObj)
                    }
                } catch {
                    debugPrint(error)
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
        case rules = "rules"
        case apps = "apps"
    }
}

final class Storage: ObservableObject {
    
    static let shared = Storage()
    
    private let appCategoriesPublisher = PassthroughSubject<Void, Never>()
    @UserDefault(.appCategories, defaultValue: [AppCategory]())
    var appCategories: [AppCategory] {
        willSet {
            appCategoriesPublisher.send()
        }
    }
    
    private let rulesPublisher = PassthroughSubject<Void, Never>()
    @UserDefault(.rules, defaultValue: [Rule]())
    var rules: [Rule] {
        willSet {
            rulesPublisher.send()
        }
    }
    
    private let appsPublisher = PassthroughSubject<Void, Never>()
    @UserDefault(.apps, defaultValue: AlphabetizedList<AppFile>())
    var apps: AlphabetizedList<AppFile> {
        willSet {
            appsPublisher.send()
        }
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
