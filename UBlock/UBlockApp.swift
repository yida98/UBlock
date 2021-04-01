//
//  UBlockApp.swift
//  UBlock
//
//  Created by Yida Zhang on 2020-12-16.
//

import SwiftUI

@main
struct UBlockApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(HomeViewModel())
        }
    }
}
