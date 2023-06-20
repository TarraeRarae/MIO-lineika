//
//  ResultScreen.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.06.2023.
//

import SwiftUI

struct ResultScreen: View {
    
    @State var model: ConclusionModel
    
    @ViewBuilder var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.white)
            .overlay {
                content
            }
            .clipped()
            .shadow(color: Color(hex: 0x1B17381A, alpha: 0.1), radius: 100, y: 10)

            
    }
    
    @ViewBuilder var content: some View {
        switch model.method {
        case .straightSimplex:
            DirectMethodView(model: model)
        case .artificialVariables:
            ArtificialVariablesView(model: model)
        case .graphic:
            GraphicMethodResultView(viewModel: GraphicMethodViewModel(model: model))
        case .modifiedSimplex:
            ModifiedMethodView(model: model)
        default:
            Text("123")
        }
    }
}

struct ResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        ResultScreen(
            model: ConclusionModel(
                function: [1, 2, 3, 4],
                constraints: [[1, 2], [1, 2]],
                optimization: .max,
                method: .graphic
            )
        )
    }
}
