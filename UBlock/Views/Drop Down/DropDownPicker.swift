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
    var size: Size = .small
    @State var selection: String = Constants.selectionDefault
    @State var overlaying: Bool = false
        
    var body: some View {
        Text(selection)
            .frame(width: size == Size.small ? 80 : 200)
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
