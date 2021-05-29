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
        HStack() {
            Image(nsImage: appFile.getImage() ?? NSImage())
                .resizable()
                .frame(width: UIConstants.iconFrameSize.width, height: UIConstants.iconFrameSize.width)
            Text(appFile.name)
            Spacer()
        }
    }
}
