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
    
    private var cancellable = Set<AnyCancellable>()
    
    var validCheck: AnyPublisher<Bool, Never> {
        return CurrentValueSubject<Bool, Never>(false)
            .combineLatest($otherValue, $addingText)
            .map { result in
                return result.1 && (result.2.count > 0)
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
}
