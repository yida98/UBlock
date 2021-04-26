//
//  CategoryCellView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-23.
//

import SwiftUI

struct CategoryCellView: View {
    
    @ObservedObject var category: AppCategory
    
    var body: some View {
        VStack {
            HStack {
                Text(category.name)
            }
        }
    }
}

