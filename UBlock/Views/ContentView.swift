//
//  ContentView.swift
//  UBlock
//
//  Created by Yida Zhang on 2020-12-16.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            NavigationView {
                VStack {
                    CategoryView().environmentObject(CategoryViewModel())
                    LogView()
                    Spacer()
                }
            }.toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigation) {
                    Button(action: {
                        HomeViewModel.toggleSidebar()
                    }) {
                        Image(systemName: "sidebar.left")
                    }
                }
            }
            RulesView().environmentObject(RulesViewModel(rules: [Rule(category: AppCategory(name: "Entertainment"), weekday: [.weekday], start: Time(hour: 0, min: 0, sec: 0), end: Time(hour: 3, min: 0, sec: 0))]))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
