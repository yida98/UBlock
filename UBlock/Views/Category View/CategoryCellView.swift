//
//  CategoryCellView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-23.
//

import SwiftUI

struct CategoryCellView: View {
    
    var category: AppCategory
    
    @State var isHover = false
    
    var body: some View {
        VStack {
            HStack {
                Text(category.name)
                Spacer()
                Text("\(category.limit ?? -1)")
                    .foregroundColor(isHover ? .gray : .lightGrey)
            }
            
            RoundedRectangle(cornerRadius: 50)
                .frame(maxWidth: .infinity, maxHeight: 6)
                .foregroundColor(Color.blue)
        }
        .onHover { (value) in
            isHover = value
        }
        .contextMenu(ContextMenu(menuItems: {
            Button("Delete") {
                Storage.removeAppCategory(category)
            }
        }))
    }
}

