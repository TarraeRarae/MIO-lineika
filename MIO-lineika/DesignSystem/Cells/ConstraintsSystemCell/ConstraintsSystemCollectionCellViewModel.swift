//
//  ConstraintsSystemCollectionCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 30.12.2022.
//

import Foundation

final class ConstraintsSystemCollectionCellViewModel {

    // MARK: - Internal properties

    weak var delegate: ConstraintsSystemCollectionCellViewModelDelegate?

    var uniqueId: UUID {
        return model.uniqueId
    }

    // MARK: - Private properties

    private var cell: ConstraintsSystemCollectionCell?

    private let model: ConstraintsSystemCollectionCell.Configuration

    // MARK: - Initializers

    init(model: ConstraintsSystemCollectionCell.Configuration) {
        self.model = model
    }
}

// MARK: - CollectionCellViewModelProtocol

extension ConstraintsSystemCollectionCellViewModel: CollectionCellViewModelProtocol {

    func configure(_ cell: ConstraintsSystemCollectionCell) {
        cell.configure(model)
        cell.viewModel = self
        self.cell = cell
    }
}

// MARK: - Private methods

private extension ConstraintsSystemCollectionCellViewModel {

    func validate(text: String) -> (Bool, String?) {
        guard let value = Int(text) else {
            return (false, L10n.Error.TextField.onlyNumbers)
        }
        if value == 0 {
            return (true, nil)
        }
        if text.first == "0" {
            return (false, L10n.Error.TextField.onlyNumbers)
        }
        return (true, nil)
    }
}

// MARK: - ConstraintsSystemCollectionCellViewModelOuput

extension ConstraintsSystemCollectionCellViewModel: ConstraintsSystemCollectionCellViewModelOuput {

    @discardableResult
    func valueDidChange(text: String, for tag: Int) -> (Bool, String?) {
        guard let value = Int(text) else {
            delegate?.clearConstraintsValue(for: tag)
            return (false, L10n.Error.TextField.onlyNumbers)
        }
        let result = validate(text: text)
        if result.0 {
            delegate?.constraintsSystemValueDidChange(value: value, for: tag)
            return result
        }

        delegate?.clearConstraintsValue(for: tag)
        return result
    }

    func showAlert(title: String, description: String?) {
        delegate?.showAlert(title: title, description: description)
    }
}
