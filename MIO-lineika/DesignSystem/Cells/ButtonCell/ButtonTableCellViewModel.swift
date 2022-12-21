//
//  ButtonTableCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

final class ButtonTableCellViewModel {

    // MARK: - Private properties

    private let model: ButtonTableCell.Configuration

    // MARK: - Initializers

    init(model: ButtonTableCell.Configuration) {
        self.model = model
    }
}

// MARK: - TableCellViewModelProtocol

extension ButtonTableCellViewModel: TableCellViewModelProtocol {

    func configure(_ cell: ButtonTableCell) {
        cell.configure(model)
    }
}
