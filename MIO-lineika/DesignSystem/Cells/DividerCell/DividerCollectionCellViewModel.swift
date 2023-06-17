//
//  DividerCollectionCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

final class DividerCollectionCellViewModel {

    // MARK: - Internal properties

    var uniqueId: UUID {
        return model.uniqueId
    }

    // MARK: - Private properties

    private let model: DividerCollectionCell.Configuration

    // MARK: - Initializers

    init(model: DividerCollectionCell.Configuration) {
        self.model = model
    }
}

// MARK: - CollectionCellViewModelProtocol

extension DividerCollectionCellViewModel: CollectionCellViewModelProtocol {

    func configure(_ cell: DividerCollectionCell) {
        cell.configure(model)
    }
}
