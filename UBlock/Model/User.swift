//
//  User.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-03-31.
//

import Foundation

class User: ObservableObject {
    var id: UUID = UUID()
        
    @Published var categories: [AppCategory] = [AppCategory]()
    


}
