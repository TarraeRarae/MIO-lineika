//
//  TextFieldTableCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

final class TextFieldTableCellViewModel {

    // MARK: - Private properties

    private let model: TextFieldTableCell.Configuration

    // MARK: - Initializers

    init(model: TextFieldTableCell.Configuration) {
        self.model = model
    }
}

// MARK: - TableCellViewModelProtocol

extension TextFieldTableCellViewModel: TableCellViewModelProtocol {

    func configure(_ cell: TextFieldTableCell) {
        cell.configure(model)
    }
}
