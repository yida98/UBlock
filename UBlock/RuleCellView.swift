//
//  RuleCellView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import SwiftUI

struct RuleCellView: View {
    
    var rule: Rule
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RuleCellView_Previews: PreviewProvider {
    static var previews: some View {
        RuleCellView(rule: Rule(category: Category(title: "Entertainment", apps: [URL]()), duration: [.Friday], start: Time(hour: 0, min: 0, sec: 0), end: Time(hour: 3, min: 0, sec: 0)))
    }
}
