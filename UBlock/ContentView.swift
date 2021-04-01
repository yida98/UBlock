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
        Text("Hello, world!")
            .padding()
        ForEach(viewModel.apps, id: \.self) { app in
            Image(nsImage: app.image)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
