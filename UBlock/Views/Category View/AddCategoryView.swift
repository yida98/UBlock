//
//  AddCategoryView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-12.
//

import SwiftUI

struct AddCategoryView: View {
    
    @State var name: String = ""
    @EnvironmentObject var viewModel: CategoryViewModel
    
    var body: some View {
            VStack {
                TextField("New Category", text: $viewModel.addingText)
                AppSelectionView()
                HStack {
                    
                    Button("Done") {
                        viewModel.finish(true)
                    }.disabled(!viewModel.isValid)
                    
                    Button("Cancel") {
                        viewModel.finish()
                    }
                }
            }
            .padding()
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}
