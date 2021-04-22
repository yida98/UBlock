//
//  AddCategoryView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-12.
//

import SwiftUI

struct AddCategoryView: View {
    
    @State var name: String = ""
    var body: some View {
        TextField("Category Name", text: $name)
        ScrollView {
            ForEach(Storage.shared.apps, id: \.self) { app in
                VStack {
                    Image(nsImage: app.getImage() ?? NSImage(contentsOf: Constants.sampleIconURL)!)
                    Text(app.name)
                }
            }
        }
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}
