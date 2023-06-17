//
//  VariablesAndConstraintsCollectionCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

final class VariablesAndConstraintsCollectionCellViewModel {

    // MARK: - Internal properties

    weak var delegate: VariablesAndConstraintsCollectionCellViewModelDelegate?

    var uniqueId: UUID {
        return model.uniqueId
    }

    // MARK: - Private properties

    private let model: VariablesConstraintsCollectionCell.Configuration

    // MARK: - Initializers

    init(model: VariablesConstraintsCollectionCell.Configuration) {
        self.model = model
    }
}

// MARK: - Private methods

private extension VariablesAndConstraintsCollectionCellViewModel {

    func validate(text: String) -> (Bool, String?) {
        guard let value = Int(text)
        else {
            return (false, L10n.Error.TextField.onlyTwoAndThree)
        }
        switch model.configurableSetting {
        case .constraints:
            if value < 1 {
                return (false, L10n.Error.TextField.maxNine)
            }
        case .variables:
            if !(2...3).contains(value) {
                return (false, L10n.Error.TextField.onlyTwoAndThree)
            }
        }
        return (true, nil)
    }
}

// MARK: - CollectionCellViewModelProtocol

extension VariablesAndConstraintsCollectionCellViewModel: CollectionCellViewModelProtocol {

    func configure(_ cell: VariablesConstraintsCollectionCell) {
        cell.configure(model)
        cell.viewModel = self
    }
}

// MARK: - TextFieldTableCellViewModelOutput

extension VariablesAndConstraintsCollectionCellViewModel: VariablesAndConstraintsCollectionCellViewModelOutput {

    func showAlert(title: String, description: String?) {
        delegate?.showAlert(title: title, description: description)
    }

    @discardableResult
    func valueDidChange(text: String) -> (Bool, String?) {
        guard let value = Int(text) else {
            delegate?.valueDidChange(for: model.configurableSetting, with: 0)
            return (false, L10n.Error.TextField.onlyTwoAndThree)
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
