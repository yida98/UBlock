//
//  AppCellView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import SwiftUI

struct AppCellView: View {
    
    var title: String
    var icon: NSImage?
    @State var selected: Bool?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AppCellView_Previews: PreviewProvider {
    static var previews: some View {
        AppCellView(title: "Some Title")
    }
}
