//
//  ConclusionSectionItem.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 09.01.2023.
//

import UIKit

enum ConclusionSectionItem: Hashable {

    // MARK: - Internal properties

    var identifier: String {
        switch self {
        case .button(let viewModel):
            return viewModel.uniqueId.uuidString
        }
    }
    
    // MARK: - Cases

    case button(ButtonTableCellViewModel)

    // MARK: - Internal methods

    func getCellSize(cellWidth: CGFloat) -> CGSize {
        let cell: UICollectionViewCell

        switch self {
        case .button(let viewModel):
            let innerCell = ButtonTableCell()
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

    static func == (lhs: ConclusionSectionItem, rhs: ConclusionSectionItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
