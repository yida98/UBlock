//
//  Nameable.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-03-31.
//

import Foundation

protocol Nameable {
    var name: String { get set }
}

protocol Indexed {
    var id: Int { get set }
}
