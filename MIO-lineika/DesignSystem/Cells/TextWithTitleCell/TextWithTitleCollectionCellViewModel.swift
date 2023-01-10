//
//  TextWithTitleCollectionCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 10.01.2023.
//

import Foundation

final class TextWithTitleCollectionCellViewModel {

    // MARK: - Internal properties

    var uniqueId: UUID {
        return model.uniqueId
    }

    // MARK: - Private properties

    private let model: TextWithTitleCollectionCell.Configuration

    // MARK: - Initializers

    init(model: TextWithTitleCollectionCell.Configuration) {
        self.model = model
    }
}

// MARK: - CollectionCellViewModelProtocol

extension TextWithTitleCollectionCellViewModel: CollectionCellViewModelProtocol {
    
    func configure(_ cell: TextWithTitleCollectionCell) {
        cell.configure(model)
    }
}
