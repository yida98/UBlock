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
        HStack (alignment: .top){
            Text("No")
            FilterablePicker<AppCategory>().environmentObject(FilterablePickerViewModel<AppCategory>(list: user.categories))
        }
        
    }
}

struct RuleAddCellView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User()
        let cat1 = AppCategory(name: "Entertainment", apps: [URL]())
        let cat2 = AppCategory(name: "Productivity", apps: [URL]())
        user.categories.append(cat1)
        user.categories.append(cat2)
        return RuleAddCellView().environmentObject(user)
    }
}
