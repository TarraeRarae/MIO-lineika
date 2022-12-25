//
//  TextFieldTableCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

final class VariablesAndConstraintsTableCellViewModel {

    // MARK: - Internal properties

    weak var delegate: VariablesAndConstraintsTableCellViewModelDelegate?

    var uniqueId: UUID {
        return model.uniqueId
    }

    // MARK: - Private properties

    private let model: VariablesConstraintsTableCell.Configuration

    // MARK: - Initializers

    init(model: VariablesConstraintsTableCell.Configuration) {
        self.model = model
    }
}

// MARK: - Private methods

private extension VariablesAndConstraintsTableCellViewModel {

    func validate(text: String) -> (Bool, String?) {
        guard let value = Int(text),
              (2...3).contains(value)
        else {
            return (false, L10n.Error.TextField.onlyNumbers)
        }
        return (true, nil)
    }
}

// MARK: - CollectionCellViewModelProtocol

extension VariablesAndConstraintsTableCellViewModel: CollectionCellViewModelProtocol {

    func configure(_ cell: VariablesConstraintsTableCell) {
        cell.configure(model)
        cell.viewModel = self
    }
}

// MARK: - TextFieldTableCellViewModelOutput

extension VariablesAndConstraintsTableCellViewModel: VariablesAndConstraintsTableCellViewModelOutput {

    func showAlert(title: String, description: String?) {
        delegate?.showAlert(title: title, description: description)
    }

    func valueDidChange(text: String) -> (Bool, String?) {
        guard let value = Int(text) else {
            delegate?.valueDidChange(for: model.configurableSetting, with: 0)
            return (false, L10n.Error.TextField.onlyNumbers)
        }
        let result = validate(text: text)
        if result.0 {
            delegate?.valueDidChange(for: model.configurableSetting, with: value)
            return result
        }

        delegate?.valueDidChange(for: model.configurableSetting, with: 0)
        return result
    }
}
