//
//  RuleAddCellView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import SwiftUI

struct RuleAddCellView: View {
    @EnvironmentObject var viewModel: RulesViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .top){
                Text("No")
                DropDownPicker<AppCategory>(list: viewModel.appCategories)
            }.zIndex(1)
            Button("Done") {
                
            }
        }
    }
}

struct RuleAddCellView_Previews: PreviewProvider {
    static var previews: some View {
        let rule1 = Rule(category: AppCategory(name: "Entertainment"), weekday: [.everyday], start: Time(hour: 0, min: 0), end: Time(hour: 4, min: 4))
        let rule2 = Rule(category: AppCategory(name: "Productivity"), weekday: [.everyday], start: Time(hour: 0, min: 0), end: Time(hour: 4, min: 4))
        let rules = [rule1, rule2]
        return RuleAddCellView().environmentObject(RulesViewModel(rules: rules))
    }
}
