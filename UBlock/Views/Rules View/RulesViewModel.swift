//
//  RulesViewModel.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import Foundation

class RulesViewModel: ObservableObject {
    
    @Published var rules: [Rule]
    @Published var appCategories: [AppCategory]
    
    init(rules: [Rule]) {
        self.rules = rules
        self.appCategories = UserDefaults.appCategories
    }
    
}
