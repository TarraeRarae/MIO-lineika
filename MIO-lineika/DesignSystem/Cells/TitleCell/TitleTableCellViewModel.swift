//
//  TitleTableCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

final class TitleTableCellViewModel {

    // MARK: - Private properties

    private let model: TitleTableCell.Configuration

    // MARK: - Initializers

    init(model: TitleTableCell.Configuration) {
        self.model = model
    }
}

// MARK: - TableCellViewModelProtocol

extension TitleTableCellViewModel: TableCellViewModelProtocol {
    
    func configure(_ cell: TitleTableCell) {
        cell.configure(model)
    }
}
