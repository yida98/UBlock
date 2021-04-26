//
//  AppCellView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import SwiftUI

struct AppCellView: View {
    
    var appFile: AppFile
    @State var selected: Bool?
    
    var body: some View {
        VStack() {
            Spacer()
            Image(nsImage: appFile.getImage() ?? NSImage())
            Text(appFile.name)
            
        }
    }
}
