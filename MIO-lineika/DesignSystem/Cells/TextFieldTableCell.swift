//
//  TextFieldTableCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit
import SnapKit

final class TextFieldTableCell: TableViewCell {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 30
        static let defaultCornerRadius: CGFloat = 0

        enum TextField {
            static let width: CGFloat = 37
            static let insets = UIEdgeInsets(top: 2, left: 15, bottom: 8, right: 15)
        }

        enum TitleLabel {
            static let insets = UIEdgeInsets(top: 10, left: 25, bottom: 8, right: 0)
        }
    }

    // MARK: - Private properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        return textField
    }()

    private var uniqueId: UUID?

    private var editingAction: ((UUID, Int) -> Void)?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = nil
        titleLabel.text = nil
        layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
        layer.cornerRadius = Constants.defaultCornerRadius
    }

    // MARK: - Configurable Item

    override func configure(_ params: Any) {
        guard let configuration = params as? Configuration
        else { return }

        titleLabel.text = configuration.configurableSetting.title

        switch configuration.configurableSetting {
        case .variables(let value):
            textField.text = String(value)
        case .constraints(let value):
            textField.text = String(value)
        }

        switch configuration.roundCornersStyle {
        case .top:
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            layer.cornerRadius = Constants.cornerRadius
        case .bottom:
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            layer.cornerRadius = Constants.cornerRadius
        case .full:
            layer.cornerRadius = Constants.cornerRadius
        case .none:
            break
        }
    }
}

// MARK: - Private methods

private extension TextFieldTableCell {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        applyTheme()
    }

    func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
    }

    func setupLayouts() {
        titleLabel.snp.contentHuggingHorizontalPriority = .infinity

        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.TextField.insets.top)
            $0.width.equalTo(Constants.TextField.width)
            $0.bottom.equalToSuperview().inset(Constants.TextField.insets.bottom)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(Constants.TextField.insets.left)
            $0.trailing.lessThanOrEqualToSuperview().inset(Constants.TextField.insets.right)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.TitleLabel.insets.top)
            $0.leading.equalToSuperview().offset(Constants.TitleLabel.insets.left)
            $0.bottom.equalToSuperview().inset(Constants.TitleLabel.insets.bottom)
        }
    }

    func applyTheme() {
        contentView.backgroundColor = .clear
        backgroundColor = DesignManager.shared.theme[.background(.tableCell)]
        textField.textColor = DesignManager.shared.theme[.text(.secondary)]
    }
}

// MARK: - Configuration

extension TextFieldTableCell {

    struct Configuration: CellModelProtocol {

        enum RoundCornersStyle {
            case top
            case bottom
            case full
            case none
        }

        /// Уникальный идентификатор ячейки
        let uniqueId = UUID()

        /// Тип ячейки для конфигурации
        let cellType = TextFieldTableCell.self

        /// Конфигурируемая настройка
        let configurableSetting: VariableConstraintsSettingsType

        /// Стиль скругления углов
        let roundCornersStyle: RoundCornersStyle

        /// Действие при изменении значения в TextField
        let editingAction: (UUID, Int) -> Void

        init(
            configurableSetting: VariableConstraintsSettingsType,
            roundCornersStyle: RoundCornersStyle = .none,
            editingAction: @escaping (UUID, Int) -> Void
        ) {
            self.configurableSetting = configurableSetting
            self.roundCornersStyle = roundCornersStyle
            self.editingAction = editingAction
        }
    }
}

// MARK: - UITextFieldDelegate

extension TextFieldTableCell: UITextFieldDelegate {

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let uniqueId = uniqueId,
              let text = textField.text,
              let value = Int(text)
        else { return false }

        editingAction?(uniqueId, value)
        return true
    }
}
