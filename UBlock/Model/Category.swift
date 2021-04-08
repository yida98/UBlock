//
//  Category.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import Foundation

struct AppCategory: Pickable, Codable {
    
    var id: String { name }
    
    var name: String
    var apps: [URL]?
    
    
}

protocol Pickable: Hashable, Identifiable, Named {
}
