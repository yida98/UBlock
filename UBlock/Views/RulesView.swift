//
//  RulesView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import SwiftUI

struct RulesView: View {
    
    @EnvironmentObject var viewModel: RulesViewModel
    @State var adding: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Rules")
                    .font(.title)
                Spacer()
                Button("+") {
                    adding = true
                }
            }
            .padding()
            if adding {
                RuleAddCellView()
            }
            ScrollView {
                ForEach(viewModel.rules) { rule in
                    RuleCellView().environmentObject(rule)
                        .padding()
                }
            }
        }
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView().environmentObject(RulesViewModel(rules: [Rule(category: AppCategory(name: "Entertainment", apps: [URL]()), weekday: [.weekday], start: Time(hour: 0, min: 0, sec: 0), end: Time(hour: 3, min: 0, sec: 0))]))
    }
}
