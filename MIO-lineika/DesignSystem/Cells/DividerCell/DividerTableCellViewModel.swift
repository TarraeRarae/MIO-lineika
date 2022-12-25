//
//  DividerTableCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

final class DividerTableCellViewModel {

    // MARK: - Internal properties

    var uniqueId: UUID {
        return model.uniqueId
    }

    // MARK: - Private properties

    private let model: DividerTableCell.Configuration

    // MARK: - Initializers

    init(model: DividerTableCell.Configuration) {
        self.model = model
    }
}

// MARK: - CollectionCellViewModelProtocol

extension DividerTableCellViewModel: CollectionCellViewModelProtocol {

    func configure(_ cell: DividerTableCell) {
        cell.configure(model)
    }
}
