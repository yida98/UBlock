//
//  AlphabetizedList.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-03-31.
//

import Foundation
import AppKit

struct AlphabetizedList<T: Nameable> {
    
    private var list: [T]
    
    init() {
        self.list = [T]()
    }
    
    mutating func insert(_ item: T) {
        list.append(item)
        list.sort { $0.name.lowercased() < $1.name.lowercased() }
    }
    
}
