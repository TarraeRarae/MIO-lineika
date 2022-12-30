//
//  MethodConfigurationViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 26.12.2022.
//

import UIKit

// MARK: - Protocols

enum MethodConfigurationRoute {
    case none
}

protocol MethodConfigurationViewModelDelegate: AnyObject {
    func showAlert(title: String, description: String?)
    func setSections(model: MethodConfigurationControllerModel)
}

protocol MethodConfigurationViewModelProtocol: AnyObject {
    var route: (MethodConfigurationRoute) -> Void { get set }
    var delegate: MethodConfigurationViewModelDelegate? { get set }

    func getTitle() -> String
}

// MARK: - MethodConfigurationViewModel

final class MethodConfigurationViewModel: MethodConfigurationViewModelProtocol {

    // MARK: - Internal properties

    weak var delegate: MethodConfigurationViewModelDelegate? {
        didSet {
            commonInit()
        }
    }

    var route: (MethodConfigurationRoute) -> Void = { _ in }

    // MARK: - Private properties

    private let model: MethodConfigurationModel

    private var cellViewModels = [AnyCollectionViewCellModelProtocol]()

    // MARK: - Initializers

    init(model: MethodConfigurationModel) {
        self.model = model
    }

    // MARK: - Internal properties

    func getTitle() -> String {
        return model.method.title
    }
}

// MARK: - Private methods

private extension MethodConfigurationViewModel {

    func commonInit() {
        setupViewModels()
    }

    func setupViewModels() {
        let topDividerViewModel = CollectionCellViewModelConstructor.shared.makeDividerCellViewModel(
            topOffset: 10,
            bottomOffset: 12
        )

        let bottomDividerViewModel = CollectionCellViewModelConstructor.shared.makeDividerCellViewModel(
            topOffset: 14,
            bottomOffset: 16
        )

        let buttonViewModel = CollectionCellViewModelConstructor.shared.makeButtonCellViewModel(
            buttonType: .conclusion,
            isEnabled: false,
            roundCornersStyle: .bottom,
            insets: UIEdgeInsets(top: 18, left: 25, bottom: 20, right: 25)
        ) {
            print("❌❌❌")
        }

        var labelsTexts = [String]()

        for index in 1...model.variables {
            labelsTexts.append("x\(index) ≥ 0")
        }

        let configurableTextViewModel = CollectionCellViewModelConstructor.shared.makeConfigurableTextCellViewModel(
            title: L10n.MethodConfigurationScreen.TextCell.title,
            labelsTexts: labelsTexts
        )

        let functionInputViewModel = CollectionCellViewModelConstructor.shared.makeFunctionInputCellViewModel(
            title: L10n.MethodConfigurationScreen.FunctionCell.title,
            variables: model.variables,
            optimization: model.optimization,
            roundCornersStyle: .top,
            delegate: self
        )

        let constraintsSystemViewModel = CollectionCellViewModelConstructor.shared.makeConstraintsSystemCollectionCellViewModel(
            titleText: L10n.MethodConfigurationScreen.ConstraintsSystemCell.title,
            variables: model.variables,
            constraints: model.constraints,
            delegate: self
        )

        cellViewModels = [
            functionInputViewModel,
            topDividerViewModel,
            constraintsSystemViewModel,
            bottomDividerViewModel,
            configurableTextViewModel,
            buttonViewModel
        ]

        setupSections()
    }

    func setupSections() {
        var sectionItems = [MethodConfigurationSectionItem]()

        for viewModel in cellViewModels {
            if let dividerViewModel = viewModel as? DividerTableCellViewModel {
                let sectionItem = MethodConfigurationSectionItem.divider(dividerViewModel)
                sectionItems.append(sectionItem)
                continue
            }

            if let buttonViewModel = viewModel as? ButtonTableCellViewModel {
                let sectionItem = MethodConfigurationSectionItem.button(buttonViewModel)
                sectionItems.append(sectionItem)
                continue
            }

            if let configurableTextViewModel = viewModel as? ConfigurableCollectionTextCellViewModel {
                let sectionItem = MethodConfigurationSectionItem.configurableText(configurableTextViewModel)
                sectionItems.append(sectionItem)
                continue
            }

            if let functionInputViewModel = viewModel as? FunctionInputCollectionCellViewModel {
                let sectionItem = MethodConfigurationSectionItem.funcitonInput(functionInputViewModel)
                sectionItems.append(sectionItem)
                continue
            }
    
            if let constraintsSystemViewModel = viewModel as? ConstraintsSystemCollectionCellViewModel {
                let sectionItem = MethodConfigurationSectionItem.constraintsSystem(constraintsSystemViewModel)
                sectionItems.append(sectionItem)
                continue
            }
        }

        let model = MethodConfigurationControllerModel(sections: [.main: sectionItems])

        delegate?.setSections(model: model)
    }
}

// MARK: - FunctionInputCollectionCellViewModelDelegate

extension MethodConfigurationViewModel: FunctionInputCollectionCellViewModelDelegate {

    func showAlert(title: String, description: String?) {
        delegate?.showAlert(title: title, description: description)
    }
}

extension MethodConfigurationViewModel: ConstraintsSystemCollectionCellViewModelDelegate {

    func constraintsSystemValueDidChange(text: String) {}
}
