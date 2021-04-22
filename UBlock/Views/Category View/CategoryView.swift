//
//  CategoryView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-10.
//

import SwiftUI

struct CategoryView: View {
    
    @State var adding: Bool = false
    @State var addingField: String = ""
    
    @ObservedObject var storage = Storage.shared
    
    var body: some View {
        VStack {
            HStack {
                Text("Hello, world!")
                    .padding()
                Button("+") {
                    adding = true
                }
            }
            if adding {
                VStack {
                    TextField("Category Name", text: $addingField)
                    AppSelectionView()
                    Button("Done") {
                        let newCategory = AppCategory(name: addingField)
                        Storage.shared.appCategories.insert(newCategory)

                        addingField = ""
                        adding.toggle()
                    }
                }
                .padding()
            }
            ForEach(Array(storage.appCategories), id: \.self) { category in
                Text(category.name)
                    .contextMenu(ContextMenu(menuItems: {
                        Button("Delete") {
                            if let item = Storage.shared.appCategories.firstIndex(of: category) {
                                Storage.shared.appCategories.remove(at: item)
                            } else {
                                // Should never come here, but if you're here, dw
                                debugPrint("Can't find this category")
                            }
                        }
                    }))
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
