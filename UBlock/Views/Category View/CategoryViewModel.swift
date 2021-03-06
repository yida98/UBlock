//
//  CategoryViewModel.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-21.
//

import Foundation
import SwiftUI
import Combine

class CategoryViewModel: ObservableObject {
    @Published var adding: Bool = false
    @Published var addingText: String = ""
    @Published var otherValue: Bool = true
    @Published var isValid: Bool = false
    
    @Published var limitHr: String = ""
    @Published var limitMin: String = ""
    @Published var hasLimit: Bool = false
    
    private var cancellable = Set<AnyCancellable>()
    
    private var validCheck: AnyPublisher<Bool, Never> {
        return CurrentValueSubject<Bool, Never>(false)
            .combineLatest($otherValue, $addingText)
            .map { result in
                return result.1 && (result.2.count > 0) && AppCategory.validity(for: result.2)
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        validCheck
            .receive(on: RunLoop.main)
            .sink { (value) in
                self.isValid = value
            }
            .store(in: &cancellable)
    }
    
    func finish(_ isDone: Bool = false) {
        if isDone {
            let newCategory = AppCategory(name: addingText)
            Storage.insert(newCategory)
        }
        addingText = ""
        adding = false
    }
}
