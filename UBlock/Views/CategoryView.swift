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
                TextField("Category Name", text: $addingField)
            }
            ForEach(Storage.shared.appCategories, id: \.self) { category in
                Text(category.name)
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
