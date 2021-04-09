//
//  DropDownPicker.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import SwiftUI

struct DropDownPicker<T: Pickable>: View {
    
//    @EnvironmentObject var viewModel: DropDownViewModel<T>
    
    var list: Array<T>
    @State var selection: String = "None"
    
    @State var overlaying: Bool = false
        
    var body: some View {
        Text(selection)
            .frame(width: Constants.boundWidth)
            .background(Color.white)
            .onTapGesture {
                overlaying.toggle()
            }
            .modifier(DropDownList(isPresented: $overlaying, content: {
                ScrollView {
                    ForEach(list, id: \.self) { item in
                        PickerItemView<T>(item: item)
                            .onTapGesture {
                                selection = item.name
                                overlaying.toggle()
                            }
                    }
                }
                .background(Color.white)
                .cornerRadius(8)
            }))
    }
}
