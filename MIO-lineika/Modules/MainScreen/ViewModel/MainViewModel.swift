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

    private var selectedSettings: (method: MethodType?, optimization: OptimizationType?) = (
        method: nil,
        optimization: nil
    )

    private var cellViewModels = [TableCellViewModelProtocol]()

    private var methodsCellModels = [TableCellViewModelProtocol]()

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
    
        let titleCell = TableCellConstructor.shared.makeTitleCellViewModel(
            with: L10n.Methods.title,
            roundCornersStyle: .top
        )

        methodsCellModels = [
            TableCellConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.graphic),
                selectionAction: methodCellTapAction
            ),
            TableCellConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.straightSimplex),
                selectionAction: methodCellTapAction
            ),
            TableCellConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.artificialVariables),
                isEnabled: false,
                selectionAction: methodCellTapAction
            ),
            TableCellConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.modifiedSimplex),
                isEnabled: false,
                selectionAction: methodCellTapAction
            ),
            TableCellConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .method(.binarySimplex),
                isEnabled: false,
                selectionAction: methodCellTapAction
            )
        ]

        optimizationsCellModels = [
            TableCellConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .optimization(.max),
                selectionAction: optimizationCellTapAction
            ),
            TableCellConstructor.shared.makeRadiobuttonCellViewModel(
                configurableSetting: .optimization(.min),
                selectionAction: optimizationCellTapAction
            )
        ]

        let dividerCell = TableCellConstructor.shared.makeDividerCellViewModel()

        cellViewModels = [titleCell] + methodsCellModels + [dividerCell] + optimizationsCellModels
        delegate?.reloadData()
    }
}

// MARK: - Cell tap actions

private extension MainViewModel {

    func setMethodCellSelected(with uuid: UUID) {
        for model in methodsCellModels {
            guard let selectableCellModel =  model as? TableCellViewModel<
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

        delegate?.reloadData()
    }

    func setOptimizationCellSelected(with uuid: UUID) {
        for model in optimizationsCellModels {
            guard let selectableCellModel =  model as? TableCellViewModel<
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

        delegate?.reloadData()
    }
}
