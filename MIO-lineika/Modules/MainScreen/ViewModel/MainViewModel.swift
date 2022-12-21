//
//  MainViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 15.12.2022.
//

import UIKit

// MARK: - Protocols

protocol MainViewModelProtocol: AnyObject {
    var delegate: MainViewModelDelegate? { get set }

    func numberOfRows(in section: Int) -> Int
    func cellViewModelFor(indexPath: IndexPath) -> AnyTableViewCellModelProtocol?
}

protocol MainViewModelDelegate: AnyObject {
    func reloadData()
}

final class MainViewModel: MainViewModelProtocol {

    // MARK: - Internal properties

    weak var delegate: MainViewModelDelegate?

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
    )

    private var cellViewModels = [AnyTableViewCellModelProtocol]()

    private var methodsCellModels = [AnyTableViewCellModelProtocol]()

    private var settingsCellModel = [AnyTableViewCellModelProtocol]()

    private var optimizationsCellModels = [AnyTableViewCellModelProtocol]()

    // MARK: - Initializers

    init() {
        setupCellModels()
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
}

// MARK: - Private methods

private extension MainViewModel {

    func setupCellModels() {
        let methodsTitleCell = TableCellViewModelConstructor.shared.makeTitleCellViewModel(
            title: L10n.Methods.title,
            roundCornersStyle: .top
        )
    
        methodsCellModels = [
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

        optimizationsCellModels = [
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .optimization(.max),
                delegate: self
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .optimization(.min),
                delegate: self
            )
        ]

        settingsCellModel = [
            TableCellViewModelConstructor.shared.makeTextFieldCellViewModel(
                configurableSetting: .variables(value: selectedSettings.variables)
            ),
            TableCellViewModelConstructor.shared.makeTextFieldCellViewModel(
                configurableSetting: .constraints(value: selectedSettings.constraints)
            )
        ]

        let buttonCellViewModel = TableCellViewModelConstructor.shared.makeButtonCellViewModel(
            buttonType: .onward,
            isEnabled: true,
            roundCornersStyle: .bottom
        )

        let dividerCellModel = TableCellViewModelConstructor.shared.makeDividerCellViewModel()
    
        cellViewModels = [methodsTitleCell] + methodsCellModels + [dividerCellModel]

        cellViewModels += settingsCellModel + [dividerCellModel]

        cellViewModels += [optimizationTitleCell] + optimizationsCellModels

        cellViewModels += [buttonCellViewModel]

        delegate?.reloadData()
    }
}

// MARK: - Cell tap actions

private extension MainViewModel {

    func methodDidSelect(with uniqueId: UUID, method: MethodType) {
        for model in methodsCellModels {
            guard let radioButtonCellModel = model as? RadiobuttonCellViewModelInput
            else { continue }

            if radioButtonCellModel.uniqueId != uniqueId {
                radioButtonCellModel.deselectCell()
            }

            selectedSettings.method = method
        }
    }

    func optimizationDidSelect(with uniqueId: UUID, optimization: OptimizationType) {
        for model in optimizationsCellModels {
            guard let radioButtonCellModel = model as? RadiobuttonCellViewModelInput
            else { continue }

            if radioButtonCellModel.uniqueId != uniqueId {
                radioButtonCellModel.deselectCell()
            }

            selectedSettings.optimization = optimization
        }
    }

    func settingCellDidEdit(with value: Int, for uuid: UUID) {}
}

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
