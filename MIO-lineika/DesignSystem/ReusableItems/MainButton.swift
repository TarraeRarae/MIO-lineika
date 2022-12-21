//
//  MainButton.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import UIKit

final class MainButton: UIButton {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 26
    }

    // MARK: - Private properties

    private var action: (() -> Void)?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal properties

    func setButtonEnabledState(state: Bool) {
        isEnabled = state
        if isEnabled {
            backgroundColor = DesignManager.shared.theme[.mainButton(.enabled)]
            return
        }
        backgroundColor = DesignManager.shared.theme[.mainButton(.disabled)]
    }
}

// MARK: - Private methods

private extension MainButton {

    func commonInit() {
        setupButton()
        applyTheme()
    }

    func setupButton() {
        addTarget(
            self,
            action: #selector(buttonTapAction),
            for: .touchUpInside
        )
    }

    func applyTheme() {
        backgroundColor = DesignManager.shared.theme[.mainButton(.enabled)]
        layer.cornerRadius = Constants.cornerRadius
    }

    // MARK: - Button action

    @objc
    func buttonTapAction() {
        action?()
    }
}

// MARK: - Configuration Item

extension MainButton: ConfigurableItem {

    func configure(_ params: Any) {
        guard let configuration = params as? Configuration else { return }
        action = configuration.action
        setTitle(configuration.buttonType.title, for: .normal)
        setButtonEnabledState(state: configuration.isEnabled)
    }
}

// MARK: - Configuration

extension MainButton {

    struct Configuration {

        enum ButtonType {

            /// Кнопка "Далее"
            case onward

            /// Кнокп "Решение"
            case conclusion

            var title: String {
                switch self {
                case .onward:
                    return L10n.MainButton.Onward.title
                case .conclusion:
                    return  L10n.MainButton.Conclusion.title
                }
            }
        }

        /// Тип кнопки
        let buttonType: ButtonType

        /// Экшен по тапу на кнопку
        let action: (() -> Void)?

        /// Состояние кнопки
        let isEnabled: Bool

        init(
            buttonType: ButtonType,
            isEnabled: Bool,
            buttonAction: (() -> Void)? = nil
        ) {
            self.buttonType = buttonType
            self.isEnabled = isEnabled
            self.action = buttonAction
        }
    }
}
