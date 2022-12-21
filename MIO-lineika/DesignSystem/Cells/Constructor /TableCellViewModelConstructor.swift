//
//  TableCellViewModelConstructor.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit

final class TableCellViewModelConstructor {

    // MARK: - Static properties

    static let shared = TableCellViewModelConstructor()

    // MARK: - Internal properties

    func makeRadiobuttonCellViewModel(
        configurableSetting: RadiobuttonTableCell.Configuration.ConfigurableSetting,
        isEnabled: Bool = true,
        roundCornersStyle: RadiobuttonTableCell.Configuration.RoundCornersStyle = .none,
        delegate: RadiobuttonCellViewModelDelegate? = nil
    ) -> AnyTableViewCellModelProtocol {
        let configuration = RadiobuttonTableCell.Configuration(
            configurableSetting: configurableSetting,
            isEnabled: isEnabled,
            roundCornersStyle: roundCornersStyle
        )
        
        let viewModel = RadiobuttonTableCellViewModel(model: configuration)
        viewModel.delegate = delegate

        return viewModel
    }

    func makeTitleCellViewModel(
        title: String,
        roundCornersStyle: TitleTableCell.Configuration.RoundCornersStyle = .none
    ) -> TitleTableCellViewModel {
        let configuration = TitleTableCell.Configuration(
            title: title,
            roundCornersStyle: roundCornersStyle
        )

        return TitleTableCellViewModel(model: configuration)
    }

    func makeDividerCellViewModel(
        dividerStyle: DividerTableCell.Configuration.DividerStyle = .fullWidth
    ) -> DividerTableCellViewModel {
        let configuration = DividerTableCell.Configuration(dividerStyle: dividerStyle)

        return DividerTableCellViewModel(model: configuration)
    }

    func makeTextFieldCellViewModel(
        configurableSetting: VariableConstraintsSettingsType,
        delegate: VariablesAndConstraintsTableCellViewModelDelegate? = nil
    ) -> VariablesAndConstraintsTableCellViewModel {
        let configuration = VariablesAndConstraintsTableCell.Configuration(
            configurableSetting: configurableSetting
        )

        let viewModel = VariablesAndConstraintsTableCellViewModel(model: configuration)
        viewModel.delegate = delegate

        return viewModel
    }

    func makeButtonCellViewModel(
        buttonType: MainButton.Configuration.ButtonType,
        isEnabled: Bool,
        roundCornersStyle: ButtonTableCell.Configuration.RoundCornersStyle = .none,
        action: (() -> Void)? = nil
    ) -> ButtonTableCellViewModel {
        let configuration = ButtonTableCell.Configuration(
            buttonConfiguration: MainButton.Configuration(
                buttonType: buttonType,
                isEnabled: isEnabled,
                buttonAction: action
            ),
            roundCornersStyle: roundCornersStyle
        )

        return ButtonTableCellViewModel(model: configuration)
    }
}
