//
//  View+Extension.swift
//  MIO-lineika
//
//  Created by Misha Fedorov on 17.06.2023.
//

import SwiftUI

fileprivate struct BaseToolBarModifier: ViewModifier {
    
    @Environment(\.dismiss) var dismiss
    
    var title: String
    var backButtonHidden: Bool
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(uiImage: Asset.Arrows.pinkChevronLeft.image)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(
                            FontFamily.Nunito.semiBold.swiftUIFont(size: 16)
                        )
                }
            }
    }
}

extension View {
    
    func rootToolBar(title: String) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(
                            FontFamily.Nunito.bold.swiftUIFont(size: 24)
                        )
                }
            }
    }
    
    func baseToolbar(_ title: String = "", backButtonHidden: Bool = false) -> some View {
        self
            .modifier(BaseToolBarModifier(title: title, backButtonHidden: backButtonHidden))
    }
}
