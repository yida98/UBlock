//
//  AppCategory.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import Foundation

struct AppCategory: Pickable {
    
    var id: String { name }
    
    var name: String
    var apps: [URL] = [URL]()
    init(name: String, apps: [URL] = [URL]()) {
        self.name = name
        self.apps = apps
    }
    
    
}

protocol Pickable: Hashable, Identifiable, Named {
}
