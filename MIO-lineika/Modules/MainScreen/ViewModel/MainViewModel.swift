//
//  MainViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 15.12.2022.
//

import UIKit

// MARK: - Protocols

enum MainViewModelRoute {
    case toMethodConfiguration(model: MethodConfigurationModel)
}

protocol MainViewModelProtocol: AnyObject {
    var delegate: MainViewModelDelegate? { get set }
    var route: (MainViewModelRoute) -> Void { get set }
}

protocol MainViewModelDelegate: AnyObject {
    func setSections(model: MainViewControllerModel)
    func showAlert(title: String, description: String?)
}

// MARK: - MainViewModel

final class MainViewModel: MainViewModelProtocol {

    // MARK: - Internal properties

    var route: (MainViewModelRoute) -> Void = { _ in }

    weak var delegate: MainViewModelDelegate? {
        didSet {
            commonInit()
        }
    }

    // MARK: - Private properties

    private var selectedSettings: (
        method: MethodType?,
        optimization: OptimizationType?,
        variables: Int,
        constraints: Int
    ) = (
        method: nil,
        optimization: nil,
        variables: 0,
        constraints: 0
    ) {
        didSet {
            if validateSelectedSettings() {
                setMainButtonIsEnabled(state: true)
                return
            }
            setMainButtonIsEnabled(state: false)
        }
    }

    private var cellViewModels = [AnyCollectionViewCellModelProtocol]()

    private var methodsCellViewModels = [AnyCollectionViewCellModelProtocol]()

    private var settingsCellViewModels = [AnyCollectionViewCellModelProtocol]()

    private var optimizationsCellViewModels = [AnyCollectionViewCellModelProtocol]()

    private var mainButtonCellViewModel: AnyCollectionViewCellModelProtocol?

}

// MARK: - Private methods

private extension MainViewModel {

    func commonInit() {
        setupCellModels()
    }

    func setupCellModels() {
        let methodsTitleCell = CollectionCellViewModelConstructor.shared.makeTitleCellViewModel(
            title: L10n.Methods.title,
            roundCornersStyle: .top,
            insets: UIEdgeInsets(top: 20, left: 25, bottom: 10, right: 25)
        )
    
        methodsCellViewModels = [
            CollectionCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.straightSimplex),
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12,
                delegate: self
            ),
            CollectionCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.graphic),
                isEnabled: false,
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12
            ),
            CollectionCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.artificialVariables),
                isEnabled: false,
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12
            ),
            CollectionCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.modifiedSimplex),
                isEnabled: false,
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12
            ),
            CollectionCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.binarySimplex),
                isEnabled: false,
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12
            )
        ]

        let optimizationTitleCell = CollectionCellViewModelConstructor.shared.makeTitleCellViewModel(
            title: L10n.Optimizations.title,
            insets: UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25)
        )

        optimizationsCellViewModels = [
            CollectionCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .optimization(.max),
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12,
                delegate: self
            ),
            CollectionCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .optimization(.min),
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12,
                delegate: self
            )
        ]

        settingsCellViewModels = [
            CollectionCellViewModelConstructor.shared.makeVariableConstraintsViewModel(
                configurableSetting: .variables(value: selectedSettings.variables),
                insets: UIEdgeInsets(top: 8, left: 25, bottom: 8, right: 62.5),
                horizontalOffset: 19,
                delegate: self
            ),
            CollectionCellViewModelConstructor.shared.makeVariableConstraintsViewModel(
                configurableSetting: .constraints(value: selectedSettings.constraints),
                insets: UIEdgeInsets(top: 8, left: 25, bottom: 8, right: 62.5),
                horizontalOffset: 19,
                delegate: self
            )
        ]

        let buttonCellViewModel = CollectionCellViewModelConstructor.shared.makeButtonCellViewModel(
            buttonType: .onward,
            isEnabled: false,
            roundCornersStyle: .bottom,
            insets: UIEdgeInsets(top: 14, left: 26, bottom: 20, right: 26)
        ) { [weak self] in
            self?.toMethodConfigurationScreen()
        }

        mainButtonCellViewModel = buttonCellViewModel

        let firstDividerCellModel = CollectionCellViewModelConstructor.shared.makeDividerCellViewModel(
            topOffset: 14,
            bottomOffset: 16
        )

        let secondDividerCellModel = CollectionCellViewModelConstructor.shared.makeDividerCellViewModel(
            topOffset: 12,
            bottomOffset: 20
        )
    
        cellViewModels = [methodsTitleCell] + methodsCellViewModels + [firstDividerCellModel]

        cellViewModels += settingsCellViewModels + [secondDividerCellModel]

        cellViewModels += [optimizationTitleCell] + optimizationsCellViewModels

        cellViewModels += [buttonCellViewModel]

        setupMainViewControllerModel()
    }

    func setupMainViewControllerModel() {
        var sectionItems = [MainSectionItem]()

        for viewModel in cellViewModels {
            if let radiobuttonModel = viewModel as? RadiobuttonCollectionCellViewModel {
                let sectionItem = MainSectionItem.radiobutton(radiobuttonModel)
                sectionItems.append(sectionItem)
                continue
            }

            if let titleModel = viewModel as? TitleCollectionCellViewModel {
                let sectionItem = MainSectionItem.title(titleModel)
                sectionItems.append(sectionItem)
                continue
            }

            if let buttonModel = viewModel as? ButtonCollectionCellViewModel {
                let sectionItem = MainSectionItem.button(buttonModel)
                sectionItems.append(sectionItem)
                continue
            }

            if let dividerModel = viewModel as? DividerCollectionCellViewModel {
                let sectionItem = MainSectionItem.divider(dividerModel)
                sectionItems.append(sectionItem)
                continue
            }

            if let variablesConstraintModel = viewModel as? VariablesAndConstraintsCollectionCellViewModel {
                let sectionItem = MainSectionItem.variablesConstraints(
                    variablesConstraintModel
                )
                sectionItems.append(sectionItem)
                continue
            }
        }

        let model = MainViewControllerModel(sections: [.main: sectionItems])

        delegate?.setSections(model: model)
    }

    func validateSelectedSettings() -> Bool {
        if (2...3).contains(selectedSettings.variables) &&
           (1...9).contains(selectedSettings.constraints) &&
           selectedSettings.method != nil &&
           selectedSettings.optimization != nil {
            return true
        }

        return false
    }

    func setMainButtonIsEnabled(state: Bool) {
        guard let buttonViewModel = mainButtonCellViewModel as? ButtonCollectionCellViewModelInput
            else { return }
        buttonViewModel.setIsButtonEnabled(state: state)
    }

    func toMethodConfigurationScreen() {
        guard let method = selectedSettings.method,
              let optimization = selectedSettings.optimization
        else { return }

        let model = MethodConfigurationModel(
            method: method,
            variables: selectedSettings.variables,
            constraints: selectedSettings.constraints,
            optimization: optimization
        )

        route(.toMethodConfiguration(model: model))
    }
}

// MARK: - Cell tap actions

private extension MainViewModel {

    func methodDidSelect(with uniqueId: UUID, method: MethodType) {
        for model in methodsCellViewModels {
            guard let radioButtonCellModel = model as? RadiobuttonCellViewModelInput
            else { continue }

            if radioButtonCellModel.uniqueId != uniqueId {
                radioButtonCellModel.deselectCell()
                continue
            }

            selectedSettings.method = method
        }
    }

    func optimizationDidSelect(with uniqueId: UUID, optimization: OptimizationType) {
        for model in optimizationsCellViewModels {
            guard let radioButtonCellModel = model as? RadiobuttonCellViewModelInput
            else { continue }

            if radioButtonCellModel.uniqueId != uniqueId {
                radioButtonCellModel.deselectCell()
                continue
            }

            selectedSettings.optimization = optimization
        }
    }
}

// MARK: - RadiobuttonCellViewModelDelegate

extension MainViewModel: RadiobuttonCellViewModelDelegate {

    func didSelectedRadiobutton(
        with uniquedId: UUID,
        for settingType: RadiobuttonCollectionCell.Configuration.ConfigurableSetting
    ) {
        switch settingType {
        case .method(let methodType):
            methodDidSelect(with: uniquedId, method: methodType)
        case .optimization(let optimizationType):
            optimizationDidSelect(with: uniquedId, optimization: optimizationType)
        }
    }
}

// MARK: - VariablesAndConstraintsTableCellViewModelDelegate

extension MainViewModel: VariablesAndConstraintsCollectionCellViewModelDelegate {

    func valueDidChange(for setting: VariableConstraintsSettingsType, with value: Int) {
        switch setting {
        case .variables:
            selectedSettings.variables = value
        case .constraints:
            selectedSettings.constraints = value
        }
    }
    
    func showAlert(title: String, description: String?) {
        delegate?.showAlert(title: title, description: description)
    }
}
