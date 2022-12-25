//
//  MainViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 15.12.2022.
//

import UIKit

// MARK: - Protocols

enum MainViewModelRoute {
    case toMethodConfiguration
}

protocol MainViewModelProtocol: AnyObject {
    var delegate: MainViewModelDelegate? { get set }
    var route: (MainViewModelRoute) -> Void { get set }

    func numberOfRows(in section: Int) -> Int
    func cellViewModelFor(indexPath: IndexPath) -> AnyCollectionViewCellModelProtocol?
    func headerFor(section: Int) -> UIView?
}

protocol MainViewModelDelegate: AnyObject {
    func setSections(model: MainViewControllerModel)
    func reloadData()
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

    private var headers = [UIView]()

    // MARK: - Internal methods

    func numberOfRows(in section: Int) -> Int {
        if section != 0 { return 0 }
        return cellViewModels.count
    }

    func cellViewModelFor(indexPath: IndexPath) -> AnyCollectionViewCellModelProtocol? {
        if indexPath.section != 0 { return nil }
        return indexPath.row <= cellViewModels.count ? cellViewModels[indexPath.row] : nil
    }

    func headerFor(section: Int) -> UIView? {
        if section > headers.count { return nil }
        return headers[section]
    }
}

// MARK: - Private methods

private extension MainViewModel {

    func commonInit() {
        setupCellModels()
        setupHeaders()
    }

    func setupCellModels() {
        let methodsTitleCell = TableCellViewModelConstructor.shared.makeTitleCellViewModel(
            title: L10n.Methods.title,
            roundCornersStyle: .top,
            insets: UIEdgeInsets(top: 20, left: 25, bottom: 10, right: 25)
        )
    
        methodsCellViewModels = [
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.graphic),
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12,
                delegate: self
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.straightSimplex),
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12,
                delegate: self
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.artificialVariables),
                isEnabled: false,
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.modifiedSimplex),
                isEnabled: false,
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.binarySimplex),
                isEnabled: false,
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12
            )
        ]

        let optimizationTitleCell = TableCellViewModelConstructor.shared.makeTitleCellViewModel(
            title: L10n.Optimizations.title,
            insets: UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25)
        )

        optimizationsCellViewModels = [
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .optimization(.max),
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12,
                delegate: self
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .optimization(.min),
                insets: UIEdgeInsets(top: 6, left: 25, bottom: 6, right: 25),
                horizontalOffset: 12,
                delegate: self
            )
        ]

        settingsCellViewModels = [
            TableCellViewModelConstructor.shared.makeVariableConstraintsViewModel(
                configurableSetting: .variables(value: selectedSettings.variables),
                insets: UIEdgeInsets(top: 8, left: 25, bottom: 8, right: 62.5),
                horizontalOffset: 19,
                delegate: self
            ),
            TableCellViewModelConstructor.shared.makeVariableConstraintsViewModel(
                configurableSetting: .constraints(value: selectedSettings.constraints),
                insets: UIEdgeInsets(top: 8, left: 25, bottom: 8, right: 62.5),
                horizontalOffset: 19,
                delegate: self
            )
        ]

        let buttonCellViewModel = TableCellViewModelConstructor.shared.makeButtonCellViewModel(
            buttonType: .onward,
            isEnabled: false,
            roundCornersStyle: .bottom,
            insets: UIEdgeInsets(top: 14, left: 26, bottom: 20, right: 26)
        ) { [weak self] in
            self?.route(.toMethodConfiguration)
        }

        mainButtonCellViewModel = buttonCellViewModel

        let firstDividerCellModel = TableCellViewModelConstructor.shared.makeDividerCellViewModel(
            topOffset: 14,
            bottomOffset: 16
        )

        let secondDividerCellModel = TableCellViewModelConstructor.shared.makeDividerCellViewModel(
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
            if let radiobuttonModel = viewModel as? RadiobuttonTableCellViewModel {
                let sectionItem = MainSectionItem.radiobutton(radiobuttonModel)
                sectionItems.append(sectionItem)
                continue
            }

            if let titleModel = viewModel as? TitleTableCellViewModel {
                let sectionItem = MainSectionItem.title(titleModel)
                sectionItems.append(sectionItem)
                continue
            }

            if let buttonModel = viewModel as? ButtonTableCellViewModel {
                let sectionItem = MainSectionItem.button(buttonModel)
                sectionItems.append(sectionItem)
                continue
            }

            if let dividerModel = viewModel as? DividerTableCellViewModel {
                let sectionItem = MainSectionItem.divider(dividerModel)
                sectionItems.append(sectionItem)
                continue
            }

            if let variablesConstraintModel = viewModel as? VariablesAndConstraintsTableCellViewModel {
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

    func setupHeaders() {
        let titleTableHeader = CollectionHeaderConstructor.shared.makeTitleTableHeader(
            title: L10n.MainScreen.Header.title,
            subtitle: L10n.MainScreen.Header.subtitle
        )

        headers.append(titleTableHeader)
    }

    func validateSelectedSettings() -> Bool {
        if (2...3).contains(selectedSettings.variables) &&
           (2...3).contains(selectedSettings.constraints) &&
           selectedSettings.method != nil &&
           selectedSettings.optimization != nil {
            return true
        }

        return false
    }

    func setMainButtonIsEnabled(state: Bool) {
        guard let buttonViewModel = mainButtonCellViewModel as? ButtonTableCellViewModelInput
            else { return }
        buttonViewModel.setIsButtonEnabled(state: state)
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
        for settingType: RadiobuttonTableCell.Configuration.ConfigurableSetting
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

extension MainViewModel: VariablesAndConstraintsTableCellViewModelDelegate {

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
