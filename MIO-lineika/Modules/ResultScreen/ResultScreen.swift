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
        switch model.method {
        case .straightSimplex:
            DirectMethodView(model: model)
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
                method: .straightSimplex
            )
        )
    }
}
