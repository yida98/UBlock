//
//  Category.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import Foundation

struct Category: Pickable {
    var selected: Bool = false
    
    var id: String { name }
    
    var name: String
    var apps: [URL]?
    
    mutating func toggleSelected() {
        selected.toggle()
    }
}

protocol Pickable: Hashable, Identifiable, Named {
    var selected: Bool { get set }
    
    mutating func toggleSelected()
}
struct AppCategory: Pickable {
    var selected: Bool = false
    
    var id: String { name }
    
    var name: String
    var apps: [URL]?
    
    mutating func toggleSelected() {
        selected.toggle()
    }
    
}
