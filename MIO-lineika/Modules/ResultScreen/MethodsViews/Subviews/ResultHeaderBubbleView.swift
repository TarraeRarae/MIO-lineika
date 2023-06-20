//
//  ResultHeaderBubbleView.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.06.2023.
//

import SwiftUI

struct ResultHeaderBubbleView: View {

    private let model: ConclusionModel

    var body: some View {
        BubbleContainerView(content: {
            VStack(alignment: .leading, spacing: 12) {
                Text("Задача")
                    .font(FontFamily.Nunito.semiBold.swiftUIFont(size: 20))
                Text("Найти оптимальное значение функции")
                    .font(FontFamily.Nunito.light.swiftUIFont(size: 12))
                Text(model.functionString)
                    .font(FontFamily.Nunito.regular.swiftUIFont(size: 14))
                Text("при следующих ограниченях")
                    .font(FontFamily.Nunito.light.swiftUIFont(size: 12))
                HStack(spacing: 6) {
                    Image(uiImage: Asset.Brackets.figuralBracket.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            height: CGFloat(model.constraintsStrings.count) * 27
                        )
                    VStack(spacing: 10) {
                        ForEach(model.constraintsStrings, id: \.id) { item in
                            Text(item)
                                .font(FontFamily.Nunito.regular.swiftUIFont(size: 14))
                        }
                    }
                }
                
                Text(model.method.methodName)
                    .font(FontFamily.Nunito.light.swiftUIFont(size: 12))
                    .foregroundColor(Color(hex: 0x2d2031))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        })
        .padding(.horizontal, 20)
    }

    init(model: ConclusionModel) {
        self.model = model
    }
}

private extension MethodType {
    var methodName: String {
        switch self {
        case .graphic:
            return "todo: "
        case .straightSimplex:
            return "прямым симлекс методом"
        case .artificialVariables:
            return "todo"
        case .modifiedSimplex:
            return "todo"
        case .binarySimplex:
            return "todo"
        }
    }
}

struct ResultBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        ResultHeaderBubbleView(model: ConclusionModel(
            function: [-1, 2, 3],
            constraints: [[1, 2, 3], [3, 4, 5], [5, 6, 7]],
            optimization: .max,
            method: .straightSimplex
        ))
    }
}
