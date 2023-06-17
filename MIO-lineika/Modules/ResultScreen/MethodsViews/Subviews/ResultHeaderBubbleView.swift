//
//  ResultHeaderBubbleView.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.06.2023.
//

import SwiftUI

struct ResultHeaderBubbleView: View {
    var body: some View {
        BubbleContainerView(content: {
            VStack(spacing: 12) {
                Text("Задача")
                    .font(FontFamily.Nunito.semiBold.swiftUIFont(size: 20))
                Text("Найти оптимальное значение функции")
                    .font(FontFamily.Nunito.light.swiftUIFont(size: 12))
                Text("Функция")
                    .font(FontFamily.Nunito.regular.swiftUIFont(size: 14))
                Text("при следующих ограниченях")
                    .font(FontFamily.Nunito.light.swiftUIFont(size: 12))
                HStack(spacing: 6) {
                    Image(uiImage: Asset.Brackets.figuralBracket.image)
                    Text("Система")
                        .font(FontFamily.Nunito.regular.swiftUIFont(size: 14))
                }
            }
        })
        .padding(.horizontal, 20)
    }
}

struct ResultBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        ResultHeaderBubbleView()
    }
}
