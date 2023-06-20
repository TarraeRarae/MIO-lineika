//
//  GraphicMethodResultView.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.06.2023.
//

import SwiftUI

struct GraphicMethodResultView: View {

    private let viewModel: IGraphicMethodViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ResultHeaderBubbleView(model: viewModel.model)
                
                Bubble(with: "Ограничение 1", img: Asset.GraphicMethodImages.l1.image)
                Bubble(with: "Ограничение 2", img: Asset.GraphicMethodImages.l2.image)
                Bubble(with: "Ограничение 3", img: Asset.GraphicMethodImages.l3.image)
                Bubble(with: "Построение нормали", img: Asset.GraphicMethodImages.l4.image)
                Bubble(with: "Область допустимых стратегий", img: Asset.GraphicMethodImages.l5.image)
                Bubble(with: nil, img: Asset.GraphicMethodImages.l6.image)
                BubbleContainerView(borderedContainer: true) {
                    VStack {

                        Image(uiImage: Asset.GraphicMethodImages.l7.image)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 20)

            }
            .padding(.vertical, 20)
        }
    }

    init(viewModel: IGraphicMethodViewModel) {
        self.viewModel = viewModel
    }
    
    func Bubble(with title: String?, img: UIImage) -> some View{
        BubbleContainerView {
            VStack {
                if let title {
                    Text(title)
                        .font(FontFamily.Nunito.regular.swiftUIFont(size: 14))
                        .foregroundColor(Color(hex: 0x2D2031))
                        .frame(alignment: .leading)
                }

                
                Image(uiImage: img)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
    }
}

struct GraphicMethodResultView_Previews: PreviewProvider {
    static var previews: some View {
        GraphicMethodResultView(
            viewModel: GraphicMethodViewModel(
                model: ConclusionModel(
                    function: [-1, 2, 3],
                    constraints: [[1, 2, 3], [3, 4, 5], [5, 6, 7]],
                    optimization: .max,
                    method: .straightSimplex
                )
            )
        )
    }
}
