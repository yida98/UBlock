//
//  User.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-07.
//

import Foundation
import Foundation

class User: ObservableObject, Codable {
    
    var id: UUID = UUID()
        
    var appCategories: [AppCategory] = [AppCategory]()
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .objectID)
        try container.encode(appCategories, forKey: .appCategories)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .objectID)
        self.appCategories = try container.decode([AppCategory].self, forKey: .appCategories)
    }
    
    init() {
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case objectID
        case appCategories
    }
}
