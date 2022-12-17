//
//  TableCellConstructor.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit

final class TableCellConstructor {

    static let shared = TableCellConstructor()

    func makeRadiobuttonCellViewModel(
        configurableSetting: RadiobuttonTableCell.Configuration.ConfigurableSetting,
        isEnabled: Bool = true,
        roundCornersStyle: RadiobuttonTableCell.Configuration.RoundCornersStyle = .none,
        selectionAction: @escaping (UUID) -> Void
    ) -> TableCellViewModel<
        RadiobuttonTableCell,
        RadiobuttonTableCell.Configuration
    > {
        let configuration = RadiobuttonTableCell.Configuration(
            configurableSetting: configurableSetting,
            isEnabled: isEnabled,
            roundCornersStyle: roundCornersStyle,
            selectionAction: selectionAction
        )
        
        return TableCellViewModel<
            RadiobuttonTableCell,
            RadiobuttonTableCell.Configuration
        >(configuration)
    }

    func makeTitleCellViewModel(
        with title: String,
        roundCornersStyle: TitleTableCell.Configuration.RoundCornersStyle = .none
    ) -> TableCellViewModel<
        TitleTableCell,
        TitleTableCell.Configuration
    > {
        let configuration = TitleTableCell.Configuration(
            title: title,
            roundCornersStyle: roundCornersStyle
        )
        
        return TableCellViewModel<
            TitleTableCell,
            TitleTableCell.Configuration
        >(configuration)
    }

    func makeDividerCellViewModel(
        dividerStyle: DividerTableCell.Configuration.DividerStyle = .fullWidth
    ) -> TableCellViewModel<
        DividerTableCell,
        DividerTableCell.Configuration
    > {
        let configuration = DividerTableCell.Configuration(dividerStyle: dividerStyle)

        return TableCellViewModel<
            DividerTableCell,
            DividerTableCell.Configuration
        >(configuration)
    }
}
