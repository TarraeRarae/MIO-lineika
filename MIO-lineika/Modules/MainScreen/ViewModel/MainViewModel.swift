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
    func cellViewModelFor(indexPath: IndexPath) -> AnyTableViewCellModelProtocol?
    func headerFor(section: Int) -> UIView?
}

protocol MainViewModelDelegate: AnyObject {
    func reloadData()
    func showAlert(title: String, description: String?)
}

final class MainViewModel: MainViewModelProtocol {

    // MARK: - Internal properties

    weak var delegate: MainViewModelDelegate?

    var route: (MainViewModelRoute) -> Void = { _ in }

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

    private var cellViewModels = [AnyTableViewCellModelProtocol]()

    private var methodsCellViewModels = [AnyTableViewCellModelProtocol]()

    private var settingsCellViewModels = [AnyTableViewCellModelProtocol]()

    private var optimizationsCellViewModels = [AnyTableViewCellModelProtocol]()

    private var mainButtonCellViewModel: AnyTableViewCellModelProtocol?

    private var headers = [UIView]()

    // MARK: - Initializers

    init() {
        commonInit()
    }

    // MARK: - Internal methods

    func numberOfRows(in section: Int) -> Int {
        if section != 0 { return 0 }
        return cellViewModels.count
    }

    func cellViewModelFor(indexPath: IndexPath) -> AnyTableViewCellModelProtocol? {
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
            roundCornersStyle: .top
        )
    
        methodsCellViewModels = [
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.graphic),
                delegate: self
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.straightSimplex),
                delegate: self
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.artificialVariables),
                isEnabled: false
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.modifiedSimplex),
                isEnabled: false
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.binarySimplex),
                isEnabled: false
            )
        ]

        let optimizationTitleCell = TableCellViewModelConstructor.shared.makeTitleCellViewModel(
            title: L10n.Optimizations.title
        )

        optimizationsCellViewModels = [
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .optimization(.max),
                delegate: self
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .optimization(.min),
                delegate: self
            )
        ]

        settingsCellViewModels = [
            TableCellViewModelConstructor.shared.makeTextFieldCellViewModel(
                configurableSetting: .variables(value: selectedSettings.variables),
                delegate: self
            ),
            TableCellViewModelConstructor.shared.makeTextFieldCellViewModel(
                configurableSetting: .constraints(value: selectedSettings.constraints),
                delegate: self
            )
        ]

        let buttonCellViewModel = TableCellViewModelConstructor.shared.makeButtonCellViewModel(
            buttonType: .onward,
            isEnabled: false,
            roundCornersStyle: .bottom
        ) {
            self.route(.toMethodConfiguration)
        }

        mainButtonCellViewModel = buttonCellViewModel

        let dividerCellModel = TableCellViewModelConstructor.shared.makeDividerCellViewModel()
    
        cellViewModels = [methodsTitleCell] + methodsCellViewModels + [dividerCellModel]

        cellViewModels += settingsCellViewModels + [dividerCellModel]

        cellViewModels += [optimizationTitleCell] + optimizationsCellViewModels

        cellViewModels += [buttonCellViewModel]

        delegate?.reloadData()
    }

    func setupHeaders() {
        let titleTableHeader = TableHeaderConstructor.shared.makeTitleTableHeader(
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
