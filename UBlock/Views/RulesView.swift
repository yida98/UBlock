//
//  RulesView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import SwiftUI

struct RulesView: View {
    
    @EnvironmentObject var viewModel: RulesViewModel
    var body: some View {
        VStack {
            HStack {
                Text("Rules")
                    .font(.title)
                Spacer()
//                Button("+") {
//                    <#code#>
//                }
            }
            .padding()
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
        RulesView().environmentObject(RulesViewModel(rules: [Rule(category: Category(id: 0, name: "Entertainment", apps: [URL]()), weekday: [.weekday], start: Time(hour: 0, min: 0, sec: 0), end: Time(hour: 3, min: 0, sec: 0))]))
    }
}