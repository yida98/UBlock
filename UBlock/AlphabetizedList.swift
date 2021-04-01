//
//  AlphabetizedList.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-03-31.
//

import Foundation
import AppKit

struct AlphabetizedList<T: Named> {
    typealias AlphaType = [T]
    
    private var alphaList: AlphaType
    
    init(alphaList: AlphaType = AlphaType()) {
        self.alphaList = alphaList
    }
    
}

extension AlphabetizedList: Collection {
    typealias Index = AlphaType.Index
    typealias Element = AlphaType.Element
    
    var startIndex: Index { return alphaList.startIndex }
    var endIndex: Index { return alphaList.endIndex }
    
    subscript(index: Index) -> AlphaType.Element {
        get { return alphaList[index] }
        set { alphaList[index] = newValue }
    }
    
    func index(after i: Index) -> Index {
        return alphaList.index(after: i)
    }

}

extension AlphabetizedList {
    
    mutating func insert(_ item: T) {
        alphaList.append(item)
        alphaList.sort { $0.name.lowercased() < $1.name.lowercased() }
    }
}

extension AlphabetizedList where T: Indexed {
    
    mutating func reindex() {
        var i = 0
        while i < alphaList.count {
            alphaList[i].id = i
            i += 1
        }
    }
    
    mutating func reindexed() -> AlphaType {
        var i = 0
        while i < alphaList.count {
            alphaList[i].id = i
            i += 1
        }
        return self.alphaList
    }
    
}
