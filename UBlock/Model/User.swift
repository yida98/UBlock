//
//  User.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-03-31.
//

import Foundation

protocol User {
    var id: UUID { get }
    var parent: User? { get }
        
}
