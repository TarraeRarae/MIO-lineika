//
//  ConclusionViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 09.01.2023.
//

import UIKit

// MARK: - Protocols

protocol ConclusionViewModelDelegate: AnyObject {
    func setSections(model: ConclusionControllerModel)
}

protocol ConclusionViewModelProtocol: AnyObject {
    var delegate: ConclusionViewModelDelegate? { get set }
}

// MARK: - ConclusionViewModel

final class ConclusionViewModel: ConclusionViewModelProtocol {

    // MARK: - Internal properties

    weak var delegate: ConclusionViewModelDelegate? {
        didSet {
            setupCellModels()
        }
    }

    // MARK: - Private properties

    private let service: StraightSimplexServiceProtocol

    private let model: ConclusionModel

    private var cellViewModels = [AnyCollectionViewCellModelProtocol]()

    // MARK: - Initializers

    init(model: ConclusionModel) {
        self.model = model
        service = StraightSimplexService()
    }
}

// MARK: - Private methods

private extension ConclusionViewModel {

    func setupCellModels() {
        let result = service.resolve(model: model)

        let textCellViewModel = CollectionCellViewModelConstructor.shared.makeTextWithTitleCollectionCellViewModel(
            title: "Решение",
            subtitle: result,
            roundCornersStyle: .full,
            insets: UIEdgeInsets(
                top: 20,
                left: 25,
                bottom: 20,
                right: 25
            )
        )

        cellViewModels.append(textCellViewModel)

        setSetctions()
    }

    func setSetctions() {
        var sectionItems = [ConclusionSectionItem]()

        for viewModel in cellViewModels {
            if let textWithTitleViewModel = viewModel as? TextWithTitleCollectionCellViewModel {
                let sectionItem = ConclusionSectionItem.textWithTitle(textWithTitleViewModel)
                sectionItems.append(sectionItem)
            }
        }

        delegate?.setSections(model: ConclusionControllerModel(sections: [.main: sectionItems]))
    }
}
