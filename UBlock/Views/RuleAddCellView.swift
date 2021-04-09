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
        VStack(alignment: .leading) {
            HStack (alignment: .top){
                Text("No")
                DropDownPicker<AppCategory>(list: user.appCategories)
            }.zIndex(1)
            Button("Done") {
                
            }
        }
    }
}

struct RuleAddCellView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User()
        let cat1 = AppCategory(name: "Entertainment", apps: [URL]())
        let cat2 = AppCategory(name: "Productivity", apps: [URL]())
        let cat3 = AppCategory(name: "Miscellaneous", apps: [URL]())
        user.appCategories.append(cat1)
        user.appCategories.append(cat2)
        user.appCategories.append(cat3)
        return RuleAddCellView().environmentObject(user)
    }
}
