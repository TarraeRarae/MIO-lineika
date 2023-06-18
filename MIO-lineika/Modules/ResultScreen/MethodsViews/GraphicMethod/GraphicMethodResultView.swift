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
        VStack {
            ResultHeaderBubbleView(model: viewModel.model)
        }
    }

    init(viewModel: IGraphicMethodViewModel) {
        self.viewModel = viewModel
    }
}

struct GraphicMethodResultView_Previews: PreviewProvider {
    static var previews: some View {
        GraphicMethodResultView(
            viewModel: GraphicMethodViewModel(
                model: ConclusionModel(
                    function: [-1, 2, 3],
                    constraints: [[1, 2, 3], [3, 4, 5], [5, 6, 7]],
                    optimization: .max
                )
            )
        )
    }
}
