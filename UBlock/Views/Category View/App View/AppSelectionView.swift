//
//  AppSelectionView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import SwiftUI

struct AppSelectionView: View {
    
    @ObservedObject var storage = Storage.shared
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(storage.apps, id: \.id) { appFile in
                    AppCellView(appFile: appFile, selected: false)
                }
            }
        }.frame(height: 120)
    }
}

struct AppSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AppSelectionView()
    }
}
