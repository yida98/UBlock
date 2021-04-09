//
//  DropDownList.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-08.
//

import Foundation
import SwiftUI

    
struct DropDownList<T: View>: ViewModifier {
    let popup: T
    var isPresented: Binding<Bool>

    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> T) {
        self.isPresented = isPresented
        popup = content()
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                popupContent()
            )

    }

    private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented.wrappedValue {
                popup
                    .offset(y: geometry.size.height)
                    .frame(idealWidth: Constants.boundWidth, maxHeight: 80)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

}
