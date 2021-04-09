//
//  DropDownViewModel.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-08.
//

import Foundation

class DropDownViewModel<T: Pickable>: ObservableObject {
    
    @Published var list: Array<T>
    
    init(_ list: Array<T>) {
        self.list = list
    }
}
