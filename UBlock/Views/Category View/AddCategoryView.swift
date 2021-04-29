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
        VStack(alignment: .leading) {
            TextField("New Category", text: $viewModel.addingText)
            Text("Limit")
                .font(.title2)
            HStack {
                TextField("Hours", text: $viewModel.limitHr)
                TextField("Minutes", text: $viewModel.limitMin)
                Text("Per")
                DropDownPicker(list: Constants.magnitude, selection: Constants.magnitude.first ?? Constants.selectionDefault)
            }.disabled(viewModel.hasLimit)
            Toggle("No limit", isOn: $viewModel.hasLimit)
            AppSelectionView()
            HStack {
                Spacer()
                Button("Cancel") {
                    viewModel.finish()
                }.padding()
                
                Button("Done") {
                    viewModel.finish(true)
                }.disabled(!viewModel.isValid)
                
            }
        }
        .padding()
        .background(Color.lightGrey3.blur(radius: 20, opaque: false))
        .cornerRadius(20)
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}
