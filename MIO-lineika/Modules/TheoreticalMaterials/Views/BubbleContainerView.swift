//
//  PDFBubbleContainerView.swift
//  MIO-lineika
//
//  Created by Misha Fedorov on 17.06.2023.
//

import SwiftUI

struct BubbleContainerView<ContentView: View>: View {
    
    var enablePaddings: Bool
    var borderedContainer: Bool = false
    var content: () -> ContentView
    
    init(_ enablePaddings: Bool = true, borderedContainer: Bool = false, content: @escaping () -> ContentView) {
        self.content = content
        self.enablePaddings = enablePaddings
        self.borderedContainer = borderedContainer
    }
    
    var body: some View {
        VStack {
            content()
                .multilineTextAlignment(.leading)
        }
        .font(FontFamily.Nunito.bold.swiftUIFont(size: 16))
        .padding(.horizontal, enablePaddings ? 24 : 0)
        .padding(.vertical, enablePaddings ? 16 : 0)
        .background(.white)
        .overlay {
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color(hex: 0xFD79A8), lineWidth: borderedContainer ? 1 : 0)

        }
        .cornerRadius(30)
        .shadow(color: Color(red: 0.11, green: 0.09, blue: 0.22, opacity: 0.12), radius: 100, x: 0, y: 10)

    }
}

struct PDFBubbleContainerView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleContainerView(content: {
            HStack {
                
                Image(uiImage: Asset.baseInformation.image)
            }
        })
        .padding(.horizontal, 20)
    }
}
