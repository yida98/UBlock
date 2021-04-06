//
//  RuleAddCellView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import SwiftUI

struct RuleAddCellView: View {
    @EnvironmentObject var user: User
    var body: some View {
        HStack {
            Text("No")
            FilterablePicker(filterList: user.categories)
        }
        
    }
}

struct RuleAddCellView_Previews: PreviewProvider {
    static var previews: some View {
        RuleAddCellView().environmentObject(User())
    }
}
