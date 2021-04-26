//
//  AppCategory.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import Foundation

class AppCategory: Pickable, Indexed, ObservableObject, Codable {
    
    @Published var id: Int = 0
    
    @Published var name: String
    @Published var apps: [URL] = [URL]()
    
    init(name: String, apps: [URL] = [URL]()) {
        self.name = name
        self.apps = apps
    }
    static func validity(for name: String) -> Bool {
        return !Storage.shared.appCategoryNames.contains(name)
    }
    
    func hash(into hasher: inout Hasher) {
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case apps
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.apps = try container.decode([URL].self, forKey: .apps)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.apps, forKey: .apps)
    }
}

extension AppCategory: Equatable {
    
    static func == (lhs: AppCategory, rhs: AppCategory) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id && lhs.apps == rhs.apps
    }
    
}

protocol Pickable: Hashable, Identifiable, Named {
}
