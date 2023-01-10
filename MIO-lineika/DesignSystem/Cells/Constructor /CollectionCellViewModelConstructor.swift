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
        configurableSetting: RadiobuttonCollectionCell.Configuration.ConfigurableSetting,
        isEnabled: Bool = true,
        roundCornersStyle: RadiobuttonCollectionCell.Configuration.RoundCornersStyle = .none,
        insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
        horizontalOffset: CGFloat = 0,
        delegate: RadiobuttonCellViewModelDelegate? = nil
    ) -> AnyCollectionViewCellModelProtocol {
        let configuration = RadiobuttonCollectionCell.Configuration(
            configurableSetting: configurableSetting,
            isEnabled: isEnabled,
            roundCornersStyle: roundCornersStyle,
            insets: insets,
            horizontalOffset: horizontalOffset
        )
        
        let viewModel = RadiobuttonCollectionCellViewModel(model: configuration)
        viewModel.delegate = delegate

        return viewModel
    }

    func makeTitleCellViewModel(
        title: String,
        roundCornersStyle: TitleCollectionCell.Configuration.RoundCornersStyle = .none,
        insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    ) -> TitleCollectionCellViewModel {
        let configuration = TitleCollectionCell.Configuration(
            title: title,
            roundCornersStyle: roundCornersStyle,
            insets: insets
        )

        return TitleCollectionCellViewModel(model: configuration)
    }

    func makeDividerCellViewModel(
        dividerStyle: DividerCollectionCell.Configuration.DividerStyle = .fullWidth,
        topOffset: CGFloat = 0,
        bottomOffset: CGFloat = 0
    ) -> DividerCollectionCellViewModel {
        let configuration = DividerCollectionCell.Configuration(
            dividerStyle: dividerStyle,
            topOffset: topOffset,
            bottomOffset: bottomOffset
        )

        return DividerCollectionCellViewModel(model: configuration)
    }

    func makeVariableConstraintsViewModel(
        configurableSetting: VariableConstraintsSettingsType,
        insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
        roundCornersStyle: VariablesConstraintsCollectionCell.Configuration.RoundCornersStyle = .none,
        horizontalOffset: CGFloat = 0,
        delegate: VariablesAndConstraintsCollectionCellViewModelDelegate? = nil
    ) -> VariablesAndConstraintsCollectionCellViewModel {
        let configuration = VariablesConstraintsCollectionCell.Configuration(
            configurableSetting: configurableSetting,
            roundCornersStyle: roundCornersStyle,
            insets: insets,
            horizontalOffset: horizontalOffset
        )

        let viewModel = VariablesAndConstraintsCollectionCellViewModel(model: configuration)
        viewModel.delegate = delegate

        return viewModel
    }

    func makeButtonCellViewModel(
        buttonType: MainButton.Configuration.ButtonType,
        isEnabled: Bool,
        roundCornersStyle: ButtonCollectionCell.Configuration.RoundCornersStyle = .none,
        insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
        action: (() -> Void)? = nil
    ) -> ButtonCollectionCellViewModel {
        let configuration = ButtonCollectionCell.Configuration(
            buttonConfiguration: MainButton.Configuration(
                buttonType: buttonType,
                isEnabled: isEnabled,
                buttonAction: action
            ),
            roundCornersStyle: roundCornersStyle,
            insets: insets
        )

        return ButtonCollectionCellViewModel(model: configuration)
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

    func makeTextWithTitleCollectionCellViewModel(
        title: String,
        subtitle: String,
        roundCornersStyle: TextWithTitleCollectionCell.Configuration.RoundCornersStyle = .none,
        insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    ) -> TextWithTitleCollectionCellViewModel {
        let configuration = TextWithTitleCollectionCell.Configuration(
            title: title,
            subtitle: subtitle,
            roundCornersStyle: roundCornersStyle,
            insets: insets
        )

        let viewModel = TextWithTitleCollectionCellViewModel(model: configuration)

        return viewModel
    }
}
