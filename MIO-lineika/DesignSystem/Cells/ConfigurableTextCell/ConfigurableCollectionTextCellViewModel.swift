//
//  ConfigurableCollectionTextCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 29.12.2022.
//

import Foundation

final class ConfigurableCollectionTextCellViewModel {

    // MARK: - Internal properties

    var uniqueId: UUID {
        return model.uniqueId
    }

    // MARK: - Private properties

    private var cell: ConfigurableCollectionTextCell?

    private let model: ConfigurableCollectionTextCell.Configuration

    // MARK: - Initializers

    init(model: ConfigurableCollectionTextCell.Configuration) {
        self.model = model
    }
}

// MARK: - CollectionCellViewModelProtocol

extension ConfigurableCollectionTextCellViewModel: CollectionCellViewModelProtocol {

    func configure(_ cell: ConfigurableCollectionTextCell) {
        cell.configure(model)
        self.cell = cell
    }
}
