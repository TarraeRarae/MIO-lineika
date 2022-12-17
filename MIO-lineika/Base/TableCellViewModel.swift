//
//  TableCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit

protocol TableCellViewModelProtocol: AnyObject {
    var cellId: String { get }
    var uniqueId: UUID { get }

    func configure(_ cell: UITableViewCell)
}

final class TableCellViewModel<
    CellType: TableViewCell,
    CellModel: CellModelProtocol
>: TableCellViewModelProtocol where CellModel.CellType == CellType.Type {

    // MARK: - Private properties

    private var configuration: CellModel

    // MARK: - Internal properties

    var cellId = String(describing: CellType.self)

    var uniqueId: UUID {
        return configuration.uniqueId
    }

    // MARK: - Initializers

    init(_ configuration: CellModel) {
        self.configuration = configuration
    }

    // MARK: - Internal methods

    func configure(_ cell: UITableViewCell) {
        guard let cell = cell as? CellType else { return }
        cell.configure(configuration)
    }
}

extension TableCellViewModel where CellType.Type == RadiobuttonTableCell.Type,
                                   CellModel == RadiobuttonTableCell.Configuration {

    var configurableSetting: RadiobuttonTableCell.Configuration.ConfigurableSetting {
        return configuration.configurableSetting
    }

    func cellDidSelected(_ isSelected: Bool) {
        configuration.isCellSelected = isSelected
    }
}