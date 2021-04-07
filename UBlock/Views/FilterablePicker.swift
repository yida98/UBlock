//
//  FilterablePicker.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-05.
//

import SwiftUI

struct FilterablePicker<T: Pickable>: View {
    
    @State var filterList: Array<T>
    @State var filter: String = ""
    
    @State var categorySelection: Int = 0
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                VStack {
                    Text("")
                        .padding(.bottom, 2)
                    ScrollView {
                        ForEach(filterList, id: \.self) { item in
                            HStack {
                                Text(item.name)
                            }
                        }
                    }.frame(maxWidth: .infinity,minHeight: 0, idealHeight: 0, maxHeight: 80, alignment: .leading)
                    .padding(.horizontal, 14)
                    .padding(.top, 4)
                    .background(Color.white)
                    .cornerRadius(8)
                }
                TextField("", text: $filter)    
                
            }
            
        }
    }
}
