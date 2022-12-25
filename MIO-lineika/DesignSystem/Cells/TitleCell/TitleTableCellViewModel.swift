//
//  TitleTableCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

final class TitleTableCellViewModel {

    // MARK: - Internal properties

    var uniqueId: UUID {
        return model.uniqueId
    }

    // MARK: - Private properties

    private let model: TitleTableCell.Configuration

    // MARK: - Initializers

    init(model: TitleTableCell.Configuration) {
        self.model = model
    }
}

// MARK: - CollectionCellViewModelProtocol

extension TitleTableCellViewModel: CollectionCellViewModelProtocol {
    
    func configure(_ cell: TitleTableCell) {
        cell.configure(model)
    }
}
