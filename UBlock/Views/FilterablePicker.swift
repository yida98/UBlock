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
    @State var selection: String = ""
    @State var categorySelection: Int = 0
    @State var myColor: Color = Color.red
        
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                VStack {
                    Text(selection)
                        .padding(.bottom, 2)
                    ScrollView {
                        ForEach(viewModel.filterList, id: \.self) { item in
                            PickerItemView<T>(item: item)
                                .onTapGesture {
                                    debugPrint("tapped \(item.name)")
                                }
                        }
                    }.frame(maxWidth: .infinity,minHeight: 0, idealHeight: 0, maxHeight: 80)
                    .padding(.top, 4)
                    .background(Color.white)
                    .cornerRadius(8)
                }
                
            }.frame(width: 180)
            
        }
    }
}
