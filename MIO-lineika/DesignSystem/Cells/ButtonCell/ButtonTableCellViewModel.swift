//
//  ButtonTableCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

final class ButtonTableCellViewModel {

    // MARK: - Private properties

    private var cell: ButtonTableCell?

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
        self.cell = cell
    }
}

// MARK: - ButtonTableCellViewModelInput

extension ButtonTableCellViewModel: ButtonTableCellViewModelInput {

    func setIsButtonEnabled(state: Bool) {
        cell?.setIsButtonEnabled(state: state)
    }
}
