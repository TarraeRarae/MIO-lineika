//
//  MethodConfigurationSectionItem.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 26.12.2022.
//

import UIKit

enum MethodConfigurationSectionItem: Hashable {

    // MARK: - Internal properties

    var identifier: String {
        switch self {
        case .button(let viewModel):
            return viewModel.uniqueId.uuidString
        case .divider(let viewModel):
            return viewModel.uniqueId.uuidString
        case .configurableText(let viewModel):
            return viewModel.uniqueId.uuidString
        case .funcitonInput(let viewModel):
            return viewModel.uniqueId.uuidString
        case .constraintsSystem(let viewModel):
            return viewModel.uniqueId.uuidString
        }
    }
    
    // MARK: - Cases

    case button(ButtonTableCellViewModel)
    case divider(DividerTableCellViewModel)
    case configurableText(ConfigurableCollectionTextCellViewModel)
    case funcitonInput(FunctionInputCollectionCellViewModel)
    case constraintsSystem(ConstraintsSystemCollectionCellViewModel)

    // MARK: - Internal methods

    func getCellSize(cellWidth: CGFloat) -> CGSize {
        let cell: UICollectionViewCell

        switch self {
        case .button(let viewModel):
            let innerCell = ButtonTableCell()
            viewModel.configure(innerCell)
            cell = innerCell
        case .divider(let viewModel):
            let innerCell = DividerTableCell()
            viewModel.configure(innerCell)
            cell = innerCell
        case .configurableText(let viewModel):
            let innerCell = ConfigurableCollectionTextCell()
            viewModel.configure(innerCell)
            cell = innerCell
        case .funcitonInput(let viewModel):
            let innerCell = FunctionInputCollectionCell()
            viewModel.configure(innerCell)
            cell = innerCell
        case .constraintsSystem(let viewModel):
            let innerCell = ConstraintsSystemCollectionCell()
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

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: MethodConfigurationSectionItem, rhs: MethodConfigurationSectionItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
