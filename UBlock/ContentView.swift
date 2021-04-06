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
            VStack {
                Text("Hello, world!")
                    .padding()
                ScrollView {
                    ForEach(viewModel.apps, id: \.self) { app in
                        Image(nsImage: app.image ?? NSImage(contentsOf: Constants.sampleIconURL)!)
                        Text(app.name)
                    }
                }
            }
            RulesView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
