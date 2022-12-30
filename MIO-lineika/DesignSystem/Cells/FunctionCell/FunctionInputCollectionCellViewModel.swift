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
        guard text.first != "0",
            let _ = Int(text) else {
            return (false, L10n.Error.TextField.onlyNumbers)
        }
        return (true, nil)
    }
}

// MARK: - FunctionInputCollectionCellViewModelOutput

extension FunctionInputCollectionCellViewModel: FunctionInputCollectionCellViewModelOutput {

    func valueDidChange(text: String) -> (Bool, String?) {
        return validate(text: text)
    }

    func showAlert(title: String, description: String?) {
        delegate?.showAlert(title: title, description: description)
    }
}
