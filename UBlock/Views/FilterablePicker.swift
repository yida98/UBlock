//
//  FilterablePicker.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import SwiftUI

struct FilterablePicker<T> where T: RandomAccessCollection & Hashable & View {
    
    @State var filterList: Array<T>
    @State var filter: String = ""
    
    @State var categorySelection: Int = 0
    
    var body: some View {
        VStack {
            TextField("", text: $filter)
            ForEach(filterList, id: \.self) { item in
                
            }
            
        }
    }
}
