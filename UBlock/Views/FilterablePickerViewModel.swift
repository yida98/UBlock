//
//  FilterablePickerViewModel.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-07.
//

import Foundation

class FilterablePickerViewModel<T: Pickable>: ObservableObject {
    
    @Published var filterList: Array<T>
    
    init(list: Array<T>) {
        self.filterList = list
    }
    
}
