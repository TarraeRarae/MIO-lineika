//
//  RadiobuttonCollectionCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

final class RadiobuttonCollectionCellViewModel {

    // MARK: - Internal properties

    weak var delegate: RadiobuttonCellViewModelDelegate?

    var uniqueId: UUID {
        return model.uniqueId
    }

    // MARK: - Private properties

    private var model: RadiobuttonCollectionCell.Configuration
    private var cell: RadiobuttonCollectionCell?

    // MARK: - Initializers

    init(model: RadiobuttonCollectionCell.Configuration) {
        self.model = model
    }
}

// MARK: - CellViewModelProtocol

extension RadiobuttonCollectionCellViewModel: CollectionCellViewModelProtocol {

    func configure(_ cell: RadiobuttonCollectionCell) {
        cell.viewModel = self
        cell.configure(model)

        self.cell = cell
    }
}


// MARK: - RadiobuttonCellViewModelProtocol

extension RadiobuttonCollectionCellViewModel: RadiobuttonCellViewModelInput {

    func deselectCell() {
        model.isRadiobuttonSelected = false
        cell?.setCellSelected(false)
    }
}

extension RadiobuttonCollectionCellViewModel: RadiobuttonCellViewModelOutput {

    func radiobuttonDidSelect() {
        model.isRadiobuttonSelected = true

        delegate?.didSelectedRadiobutton(
            with: model.uniqueId,
            for: model.configurableSetting
        )
    }
}
