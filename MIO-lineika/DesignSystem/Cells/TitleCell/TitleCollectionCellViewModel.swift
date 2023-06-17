//
//  TitleCollectionCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

final class TitleCollectionCellViewModel {

    // MARK: - Internal properties

    var uniqueId: UUID {
        return model.uniqueId
    }

    // MARK: - Private properties

    private let model: TitleCollectionCell.Configuration

    // MARK: - Initializers

    init(model: TitleCollectionCell.Configuration) {
        self.model = model
    }
}

// MARK: - CollectionCellViewModelProtocol

extension TitleCollectionCellViewModel: CollectionCellViewModelProtocol {
    
    func configure(_ cell: TitleCollectionCell) {
        cell.configure(model)
    }
}
