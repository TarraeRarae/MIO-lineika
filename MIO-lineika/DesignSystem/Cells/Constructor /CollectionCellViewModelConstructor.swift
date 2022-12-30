//
//  TableCellViewModelConstructor.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit

final class CollectionCellViewModelConstructor {

    // MARK: - Static properties

    static let shared = CollectionCellViewModelConstructor()

    // MARK: - Internal properties

    func makeRadiobuttonCellViewModel(
        configurableSetting: RadiobuttonTableCell.Configuration.ConfigurableSetting,
        isEnabled: Bool = true,
        roundCornersStyle: RadiobuttonTableCell.Configuration.RoundCornersStyle = .none,
        insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
        horizontalOffset: CGFloat = 0,
        delegate: RadiobuttonCellViewModelDelegate? = nil
    ) -> AnyCollectionViewCellModelProtocol {
        let configuration = RadiobuttonTableCell.Configuration(
            configurableSetting: configurableSetting,
            isEnabled: isEnabled,
            roundCornersStyle: roundCornersStyle,
            insets: insets,
            horizontalOffset: horizontalOffset
        )
        
        let viewModel = RadiobuttonTableCellViewModel(model: configuration)
        viewModel.delegate = delegate

        return viewModel
    }

    func makeTitleCellViewModel(
        title: String,
        roundCornersStyle: TitleTableCell.Configuration.RoundCornersStyle = .none,
        insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    ) -> TitleTableCellViewModel {
        let configuration = TitleTableCell.Configuration(
            title: title,
            roundCornersStyle: roundCornersStyle,
            insets: insets
        )

        return TitleTableCellViewModel(model: configuration)
    }

    func makeDividerCellViewModel(
        dividerStyle: DividerTableCell.Configuration.DividerStyle = .fullWidth,
        topOffset: CGFloat = 0,
        bottomOffset: CGFloat = 0
    ) -> DividerTableCellViewModel {
        let configuration = DividerTableCell.Configuration(
            dividerStyle: dividerStyle,
            topOffset: topOffset,
            bottomOffset: bottomOffset
        )

        return DividerTableCellViewModel(model: configuration)
    }

    func makeVariableConstraintsViewModel(
        configurableSetting: VariableConstraintsSettingsType,
        insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
        roundCornersStyle: VariablesConstraintsTableCell.Configuration.RoundCornersStyle = .none,
        horizontalOffset: CGFloat = 0,
        delegate: VariablesAndConstraintsTableCellViewModelDelegate? = nil
    ) -> VariablesAndConstraintsTableCellViewModel {
        let configuration = VariablesConstraintsTableCell.Configuration(
            configurableSetting: configurableSetting,
            roundCornersStyle: roundCornersStyle,
            insets: insets,
            horizontalOffset: horizontalOffset
        )

        let viewModel = VariablesAndConstraintsTableCellViewModel(model: configuration)
        viewModel.delegate = delegate

        return viewModel
    }

    func makeButtonCellViewModel(
        buttonType: MainButton.Configuration.ButtonType,
        isEnabled: Bool,
        roundCornersStyle: ButtonTableCell.Configuration.RoundCornersStyle = .none,
        insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
        action: (() -> Void)? = nil
    ) -> ButtonTableCellViewModel {
        let configuration = ButtonTableCell.Configuration(
            buttonConfiguration: MainButton.Configuration(
                buttonType: buttonType,
                isEnabled: isEnabled,
                buttonAction: action
            ),
            roundCornersStyle: roundCornersStyle,
            insets: insets
        )

        return ButtonTableCellViewModel(model: configuration)
    }

    func makeConfigurableTextCellViewModel(
        title: String,
        labelsTexts: [String]
    ) -> ConfigurableCollectionTextCellViewModel {
        let configuration = ConfigurableCollectionTextCell.Configuration(
            title: title,
            texts: labelsTexts
        )

        return ConfigurableCollectionTextCellViewModel(model: configuration)
    }

    func makeFunctionInputCellViewModel(
        title: String,
        variables: Int,
        optimization: OptimizationType,
        roundCornersStyle: FunctionInputCollectionCell.Configuration.RoundCornersStyle = .none,
        delegate: FunctionInputCollectionCellViewModelDelegate? = nil
    ) -> FunctionInputCollectionCellViewModel {
        let configuration = FunctionInputCollectionCell.Configuration(
            title: title,
            variables: variables,
            optimization: optimization,
            roundCornersStyle: roundCornersStyle
        )

        let viewModel = FunctionInputCollectionCellViewModel(model: configuration)
        viewModel.delegate = delegate

        return viewModel
    }

    func makeConstraintsSystemCollectionCellViewModel(
        titleText: String,
        variables: Int,
        constraints: Int,
        delegate: ConstraintsSystemCollectionCellViewModelDelegate? = nil
    ) -> ConstraintsSystemCollectionCellViewModel {
        let configuration = ConstraintsSystemCollectionCell.Configuration(
            titleText: titleText,
            variables: variables,
            constraints: constraints
        )

        let viewModel = ConstraintsSystemCollectionCellViewModel(model: configuration)
        viewModel.delegate = delegate

        return viewModel
    }
}
