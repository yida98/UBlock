//
//  AppCategory.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import Foundation

struct AppCategory: Pickable, Indexed, Codable {
    
    var id: Int = 0
    
    var name: String
    var apps: [URL]
    var limit: Int?
    
    init(name: String, apps: [URL] = [URL]()) {
        self.name = name
        self.apps = apps
        
    }
    
    static func validity(for name: String) -> Bool {
        return !Storage.shared.appCategoryNames.contains(name)
    }
    
    func hash(into hasher: inout Hasher) {
    }
    
}

extension AppCategory: Equatable {
    
    static func == (lhs: AppCategory, rhs: AppCategory) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id && lhs.apps == rhs.apps
    }
    
}

protocol Pickable: Hashable, Identifiable, Named {
}

extension String: Pickable {
    public var id: String { self }
    
    var name: String {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
}
