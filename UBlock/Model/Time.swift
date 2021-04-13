//
//  Time.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import Foundation

struct Time: Codable {
    var hour: Int
    var min: Int
    var sec: Int = 0
    
    func description() -> String {
        return "\(hour):\(min)"
    }
}
