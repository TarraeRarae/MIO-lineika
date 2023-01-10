//
//  ConclusionViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 09.01.2023.
//

import Foundation

// MARK: - Protocols

protocol ConclusionViewModelDelegate: AnyObject {
    func showAlert(title: String, description: String?)
    func setSections(model: ConclusionControllerModel)
}

protocol ConclusionViewModelProtocol: AnyObject {
    var delegate: ConclusionViewModelDelegate? { get set }
}

// MARK: - ConclusionViewModel

final class ConclusionViewModel: ConclusionViewModelProtocol {

    // MARK: - Internal properties

    weak var delegate: ConclusionViewModelDelegate?

    // MARK: - Private properties

    private let service: StraightSimplexServiceProtocol

    // MARK: - Initializers

    init(model: StraightSimplexModel) {
        service = StraightSimplexService()
    }
}
