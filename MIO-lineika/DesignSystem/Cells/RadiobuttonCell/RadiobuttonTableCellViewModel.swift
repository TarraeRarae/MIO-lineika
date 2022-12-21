//
//  RadiobuttonCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

final class RadiobuttonTableCellViewModel {

    // MARK: - Internal properties

    weak var delegate: RadiobuttonCellViewModelDelegate?

    var uniqueId: UUID {
        return model.uniqueId
    }

    // MARK: - Private properties

    private var model: RadiobuttonTableCell.Configuration
    private var cell: RadiobuttonTableCell?

    // MARK: - Initializers

    init(model: RadiobuttonTableCell.Configuration) {
        self.model = model
    }
}

// MARK: - CellViewModelProtocol

extension RadiobuttonTableCellViewModel: TableCellViewModelProtocol {

    func configure(_ cell: RadiobuttonTableCell) {
        cell.viewModel = self
        cell.configure(model)

        self.cell = cell
    }
}


// MARK: - RadiobuttonCellViewModelProtocol

extension RadiobuttonTableCellViewModel: RadiobuttonCellViewModelInput {

    func deselectCell() {
        model.isRadiobuttonSelected = false
        cell?.setCellSelected(false)
    }
}

extension RadiobuttonTableCellViewModel: RadiobuttonCellViewModelOutput {

    func radiobuttonDidSelect() {
        model.isRadiobuttonSelected = true

        delegate?.didSelectedRadiobutton(
            with: model.uniqueId,
            for: model.configurableSetting
        )
    }
}
