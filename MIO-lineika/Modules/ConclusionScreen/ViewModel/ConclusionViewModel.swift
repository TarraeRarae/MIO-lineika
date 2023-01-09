//
//  ConclusionViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 09.01.2023.
//

import Foundation

protocol ConclusionViewModelDelegate: AnyObject {
    func showAlert(title: String, description: String?)
    func setSections(model: ConclusionControllerModel)
}

protocol ConclusionViewModelProtocol: AnyObject {
    var delegate: ConclusionViewModelDelegate? { get set }
}

final class ConclusionViewModel: ConclusionViewModelProtocol {

    weak var delegate: ConclusionViewModelDelegate?
}
