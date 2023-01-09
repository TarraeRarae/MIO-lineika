//
//  FunctionInputCollectionCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 30.12.2022.
//

import Foundation

final class FunctionInputCollectionCellViewModel {

    // MARK: - Internal properties

    weak var delegate: FunctionInputCollectionCellViewModelDelegate?

    var uniqueId: UUID {
        return model.uniqueId
    }

    // MARK: - Private properties

    private var cell: FunctionInputCollectionCell?

    private let model: FunctionInputCollectionCell.Configuration

    // MARK: - Initializers

    init(model: FunctionInputCollectionCell.Configuration) {
        self.model = model
    }
}

// MARK: - CollectionCellViewModelProtocol

extension FunctionInputCollectionCellViewModel: CollectionCellViewModelProtocol {

    func configure(_ cell: FunctionInputCollectionCell) {
        cell.configure(model)
        cell.viewModel = self
        self.cell = cell
    }
}

// MARK: - Private methods

private extension FunctionInputCollectionCellViewModel {

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

// MARK: - FunctionInputCollectionCellViewModelOutput

extension FunctionInputCollectionCellViewModel: FunctionInputCollectionCellViewModelOutput {

    @discardableResult
    func valueDidChange(text: String, for tag: Int) -> (Bool, String?) {
        guard let value = Int(text) else {
            delegate?.clearFunctionValue(for: tag)
            return (false, L10n.Error.TextField.onlyNumbers)
        }
        let result = validate(text: text)
        if result.0 {
            delegate?.functionValueDidChange(value: value, for: tag)
            return result
        }

        delegate?.clearFunctionValue(for: tag)
        return result
    }

    func showAlert(title: String, description: String?) {
        delegate?.showAlert(title: title, description: description)
    }
}
