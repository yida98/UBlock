//
//  RuleCellView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import SwiftUI

struct RuleCellView: View {
    
    @EnvironmentObject var rule: Rule
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("edit")
                    .font(.caption)
                    .foregroundColor(.lightGrey)
            }.padding(.horizontal, 5)
            .padding(.top, 2)
            HStack {
                Text(rule.description())
                    .padding(.bottom, 10)
                    .padding(.horizontal, 20)
                    .foregroundColor(.green)
                Spacer()
            }
        }
        .frame(minWidth: 300, idealWidth: 500)
        .background(Color.lightGrey3)
        .cornerRadius(5)
    }
}

struct RuleCellView_Previews: PreviewProvider {
    static var previews: some View {
        RuleCellView().environmentObject(Rule(category: Category(id: 1, name: "Entertainment", apps: [URL]()), weekday: [.weekday], start: Time(hour: 0, min: 0, sec: 0), end: Time(hour: 3, min: 0, sec: 0)))
    }
}
