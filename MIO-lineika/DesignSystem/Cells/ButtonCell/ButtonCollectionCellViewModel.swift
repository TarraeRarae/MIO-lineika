//
//  ButtonTableCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

final class ButtonCollectionCellViewModel {

    // MARK: - Internal properties

    var uniqueId: UUID {
        return model.uniqueId
    }

    // MARK: - Private properties

    private var cell: ButtonCollectionCell?

    private let model: ButtonCollectionCell.Configuration

    // MARK: - Initializers

    init(model: ButtonCollectionCell.Configuration) {
        self.model = model
    }
}

// MARK: - CollectionCellViewModelProtocol

extension ButtonCollectionCellViewModel: CollectionCellViewModelProtocol {

    func configure(_ cell: ButtonCollectionCell) {
        cell.configure(model)
        self.cell = cell
    }
}

// MARK: - ButtonTableCellViewModelInput

extension ButtonCollectionCellViewModel: ButtonCollectionCellViewModelInput {

    func setIsButtonEnabled(state: Bool) {
        cell?.setIsButtonEnabled(state: state)
    }
}
