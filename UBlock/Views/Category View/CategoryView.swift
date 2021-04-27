//
//  CategoryView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-10.
//

import SwiftUI

struct CategoryView: View {
    
    @EnvironmentObject var viewModel: CategoryViewModel
    
    @ObservedObject var storage = Storage.shared
    
    var body: some View {
        VStack {
            HStack {
                Text("Hello, world!")
                    .font(.title)
                Spacer()
                Button("+") {
                    viewModel.adding = true
                }
            }
            if viewModel.adding {
                AddCategoryView().environmentObject(viewModel)
            }
            ForEach(Array(storage.appCategories), id: \.self) { category in
                CategoryCellView(category: category)
            }
        }.padding(30)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
