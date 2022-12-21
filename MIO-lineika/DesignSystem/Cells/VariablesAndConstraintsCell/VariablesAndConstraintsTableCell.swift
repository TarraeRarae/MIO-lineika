//
//  TextFieldTableCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit
import SnapKit

final class VariablesAndConstraintsTableCell: TableViewCell {

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

    // MARK: - Internal properties

    var viewModel: VariablesAndConstraintsTableCellViewModelOutput?
    
    // MARK: - Private properties

    private let textField = BottomLineTextField()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }()

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

        var textFieldText = ""

        switch configuration.configurableSetting {
        case .variables(let value):
            textFieldText = String(value)
        case .constraints(let value):
            textFieldText = String(value)
        }

        let textFieldModel = BottomLineTextField.Configuration(text: textFieldText)
        textField.configure(textFieldModel)

        titleLabel.text = configuration.configurableSetting.title

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

private extension VariablesAndConstraintsTableCell {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        applyTheme()
    }

    func setupSubviews() {
        textField.delegate = self
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

extension VariablesAndConstraintsTableCell {

    struct Configuration {

        enum RoundCornersStyle {
            case top
            case bottom
            case full
            case none
        }

        /// Конфигурируемая настройка
        let configurableSetting: VariableConstraintsSettingsType

        /// Стиль скругления углов
        let roundCornersStyle: RoundCornersStyle

        init(
            configurableSetting: VariableConstraintsSettingsType,
            roundCornersStyle: RoundCornersStyle = .none
        ) {
            self.configurableSetting = configurableSetting
            self.roundCornersStyle = roundCornersStyle
        }
    }
}

// MARK: - UITextFieldDelegate

extension VariablesAndConstraintsTableCell: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.textColor = DesignManager.shared.theme[.text(.secondary)]
        textField.text = ""
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let result = viewModel?.valueDidChange(text: text),
           !result.0 {
            textField.textColor = DesignManager.shared.theme[.text(.error)]
            viewModel?.showAlert(title: L10n.Error.title, description: result.1)
            return
        }

        textField.textColor = DesignManager.shared.theme[.text(.secondary)]
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let maxLength = 1
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
}
