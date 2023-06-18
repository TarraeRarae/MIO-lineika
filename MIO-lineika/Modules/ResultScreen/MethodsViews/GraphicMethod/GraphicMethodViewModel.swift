//
//  GraphicMethodViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.06.2023.
//

import Foundation

protocol IGraphicMethodViewModel: AnyObject {
    var model: ConclusionModel { get }
}

final class GraphicMethodViewModel: IGraphicMethodViewModel {

    private(set) var model: ConclusionModel

    init(model: ConclusionModel) {
        self.model = model
    }
}
