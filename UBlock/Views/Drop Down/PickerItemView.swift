//
//  PickerItemView.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-07.
//

import SwiftUI

struct PickerItemView<T: Named>: View {
    
    @State var isHovering: Bool = false
    var item: T
    
    var body: some View {
        HStack {
            Text(item.name)
            Spacer()
        }
            .padding(.horizontal, 14)
            .background(isHovering ? Color.lightGrey : nil)
            .onHover(perform: { hovering in
                isHovering = hovering
            })
    }
}

struct PickerItemView_Previews: PreviewProvider {
    static var previews: some View {
        PickerItemView(item: AppCategory(name: "Entertainment"))
    }
}
