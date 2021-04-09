//
//  FilterablePicker.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import SwiftUI

struct FilterablePicker<T: Pickable>: View {
    
    @EnvironmentObject var viewModel: FilterablePickerViewModel<T>
    
//    @State var filterList: Array<T>
    @State var selection: String = "None"
    @State var categorySelection: Int = 0
    @State var myColor: Color = Color.red
    
    @State var overlaying: Bool = false
        
    var body: some View {
        Text(selection)
            .frame(width: Constants.boundWidth)
            .background(Color.white)
            .onTapGesture {
                overlaying.toggle()
            }
            .modifier(FilterPopupView(isPresented: $overlaying, content: {
                ScrollView {
                    ForEach(viewModel.filterList, id: \.self) { item in
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
