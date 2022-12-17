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
    func cellViewModelFor(indexPath: IndexPath) -> TableCellViewModelProtocol?
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

    private var cellViewModels = [TableCellViewModelProtocol]()

    private var methodsCellModels = [TableCellViewModelProtocol]()

    private var settingsCellModel = [TableCellViewModelProtocol]()

    private var optimizationsCellModels = [TableCellViewModelProtocol]()

    // MARK: - Initializers

    init() {
        setupCellModels()
    }

    // MARK: - Internal methods

    func numberOfRows(in section: Int) -> Int {
        if section != 0 { return 0 }
        return cellViewModels.count
    }

    func cellViewModelFor(indexPath: IndexPath) -> TableCellViewModelProtocol? {
        if indexPath.section != 0 { return nil }
        return indexPath.row <= cellViewModels.count ? cellViewModels[indexPath.row] : nil
    }
}

// MARK: - Private methods

private extension MainViewModel {

    func setupCellModels() {
        let methodCellTapAction: (UUID) -> Void = { [weak self] uniqueId in
            self?.setMethodCellSelected(with: uniqueId)
        }

        let optimizationCellTapAction: (UUID) -> Void = { [weak self] uniqueId in
            self?.setOptimizationCellSelected(with: uniqueId)
        }

        let settingCellDidEdit: (UUID, Int) -> Void = { [weak self] uniqueId, value in
            self?.settingCellDidEdit(with: value, for: uniqueId)
        }
    
        let methodsTitleCell = TableCellViewModelConstructor.shared.makeTitleCellViewModel(
            with: L10n.Methods.title,
            roundCornersStyle: .top
        )

        methodsCellModels = [
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.graphic),
                selectionAction: methodCellTapAction
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.straightSimplex),
                selectionAction: methodCellTapAction
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.artificialVariables),
                isEnabled: false,
                selectionAction: methodCellTapAction
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.modifiedSimplex),
                isEnabled: false,
                selectionAction: methodCellTapAction
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.binarySimplex),
                isEnabled: false,
                selectionAction: methodCellTapAction
            )
        ]

        let optimizationTitleCell = TableCellViewModelConstructor.shared.makeTitleCellViewModel(
            with: L10n.Optimizations.title
        )

        optimizationsCellModels = [
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .optimization(.max),
                selectionAction: optimizationCellTapAction
            ),
            TableCellViewModelConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .optimization(.min),
                selectionAction: optimizationCellTapAction
            )
        ]
    
        settingsCellModel = [
            TableCellViewModelConstructor.shared.makeTextFieldCellViewModel(
                configurableSetting: .variables(value: selectedSettings.variables),
                editingAction: settingCellDidEdit
            ),
            TableCellViewModelConstructor.shared.makeTextFieldCellViewModel(
                configurableSetting: .constraints(value: selectedSettings.constraints),
                editingAction: settingCellDidEdit
            )
        ]

        let dividerCellModel = TableCellViewModelConstructor.shared.makeDividerCellViewModel()

        cellViewModels =
        [methodsTitleCell] +
        methodsCellModels +
        [dividerCellModel] +
        settingsCellModel +
        [dividerCellModel] +
        [optimizationTitleCell] +
        optimizationsCellModels

        delegate?.reloadData()
    }
}

// MARK: - Cell tap actions

private extension MainViewModel {

    func setMethodCellSelected(with uuid: UUID) {
        for model in methodsCellModels {
            guard let selectableCellModel = model as? TableCellViewModel<
                    RadiobuttonTableCell,
                    RadiobuttonTableCell.Configuration
            > else { continue }

            if model.uniqueId != uuid {
                selectableCellModel.cellDidSelected(false)
                continue
            }

            selectableCellModel.cellDidSelected(true)

            switch selectableCellModel.configurableSetting {
            case .method(let method):
                selectedSettings.method = method
            case .optimization:
                break
            }
        }
    }

    func setOptimizationCellSelected(with uuid: UUID) {
        for model in optimizationsCellModels {
            guard let selectableCellModel = model as? TableCellViewModel<
                    RadiobuttonTableCell,
                    RadiobuttonTableCell.Configuration
            > else { continue }

            if model.uniqueId != uuid {
                selectableCellModel.cellDidSelected(false)
                continue
            }

            selectableCellModel.cellDidSelected(true)

            switch selectableCellModel.configurableSetting {
            case .method:
                break
            case .optimization(let optimization):
                selectedSettings.optimization = optimization
            }
        }
    }

    func settingCellDidEdit(with value: Int, for uuid: UUID) {}
}
