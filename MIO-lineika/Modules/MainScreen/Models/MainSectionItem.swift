//
//  MainSectionItem.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 24.12.2022.
//

import UIKit

enum MainSectionItem: Hashable {

    // MARK: - Internal properties

    var identifier: String {
        switch self {
        case .title(let viewModel):
            return viewModel.uniqueId.uuidString
        case .radiobutton(let viewModel):
            return viewModel.uniqueId.uuidString
        case .variablesConstraints(let viewModel):
            return viewModel.uniqueId.uuidString
        case .button(let viewModel):
            return viewModel.uniqueId.uuidString
        case .divider(let viewModel):
            return viewModel.uniqueId.uuidString
        }
    }

    // MARK: - Cases

    case title(TitleTableCellViewModel)
    case radiobutton(RadiobuttonTableCellViewModel)
    case variablesConstraints(VariablesAndConstraintsTableCellViewModel)
    case button(ButtonTableCellViewModel)
    case divider(DividerTableCellViewModel)

    // MARK: - Static methods

    static func == (lhs: MainSectionItem, rhs: MainSectionItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    // MARK: - Internal methods

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    func getCellSize(cellWidth: CGFloat) -> CGSize {
        let cell: UICollectionViewCell

        switch self {
        case .title(let viewModel):
            let innerCell = TitleTableCell()
            viewModel.configure(innerCell)
            cell = innerCell
        case .radiobutton(let viewModel):
            let innerCell = RadiobuttonTableCell()
            viewModel.configure(innerCell)
            cell = innerCell
        case .variablesConstraints(let viewModel):
            let innerCell = VariablesConstraintsTableCell()
            viewModel.configure(innerCell)
            cell = innerCell
        case .button(let viewModel):
            let innerCell = ButtonTableCell()
            viewModel.configure(innerCell)
            cell = innerCell
        case .divider(let viewModel):
            let innerCell = DividerTableCell()
            viewModel.configure(innerCell)
            cell = innerCell
        }

        cell.layoutIfNeeded()
        let targetSize = CGSize(
            width: cellWidth,
            height: UIView.layoutFittingCompressedSize.height
        )
        let height = cell.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        ).height

        return CGSize(width: cellWidth, height: height)
    }
}
