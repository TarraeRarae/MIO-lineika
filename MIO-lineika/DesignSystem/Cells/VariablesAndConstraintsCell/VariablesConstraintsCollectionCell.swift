//
//  TextFieldTableCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit
import SnapKit

final class VariablesConstraintsCollectionCell: CollectionViewCell {

    // MARK: - Constants

    private enum Constants {
        static let maxTextLength: Int = 1
        static let cornerRadius: CGFloat = 30
        static let defaultCornerRadius: CGFloat = 0

        enum TextField {
            static let width: CGFloat = 37
            static let height: CGFloat = 24
        }
    }

    // MARK: - Internal properties

    var viewModel: VariablesAndConstraintsCollectionCellViewModelOutput?
    
    // MARK: - Private properties

    private let textField = BottomLineTextField()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
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
            textFieldText = value != 0 ? String(value) : ""
        case .constraints(let value):
            textFieldText = value != 0 ? String(value) : ""
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

        setupLayouts(with: configuration.insets, offset: configuration.horizontalOffset)
    }
}

// MARK: - Private methods

private extension VariablesConstraintsCollectionCell {

    func commonInit() {
        setupSubviews()
        applyTheme()
    }

    func setupSubviews() {
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "0",
            attributes: [
                .foregroundColor: DesignManager.shared.theme[.text(.secondary)]
            ]
        )
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
    }

    func setupLayouts(with insets: UIEdgeInsets, offset horizontalOffset: CGFloat) {
        titleLabel.snp.contentHuggingHorizontalPriority = .infinity

        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(insets.top)
            $0.width.equalTo(Constants.TextField.width)
            $0.height.equalTo(Constants.TextField.height)
            $0.trailing.equalToSuperview().inset(insets.right)
        }


        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(insets.top + 2)
            $0.leading.equalToSuperview().offset(insets.left)
            $0.bottom.equalToSuperview().inset(insets.bottom)
            $0.trailing.equalTo(textField.snp.leading).inset(horizontalOffset)
        }
    }

    func applyTheme() {
        contentView.backgroundColor = .clear
        backgroundColor = DesignManager.shared.theme[.background(.cell)]
        textField.textColor = DesignManager.shared.theme[.text(.primary)]
        titleLabel.font = FontFamily.Nunito.medium.font(size: 16)
        textField.font = FontFamily.Nunito.regular.font(size: 14)
    }
}

// MARK: - UITextFieldDelegate

extension VariablesConstraintsCollectionCell: UITextFieldDelegate {

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

        textField.textColor = DesignManager.shared.theme[.text(.primary)]
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let maxLength = Constants.maxTextLength
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        textField.textColor = DesignManager.shared.theme[.text(.primary)]
        
        let result = newString.count <= maxLength
        
        if result {
            viewModel?.valueDidChange(text: newString)
        }

        return result
    }
}

// MARK: - Configuration

extension VariablesConstraintsCollectionCell {

    struct Configuration {

        enum RoundCornersStyle {
            case top
            case bottom
            case full
            case none
        }

        /// Уникальный идентификатор модели ячейки
        let uniqueId = UUID()

        /// Конфигурируемая настройка
        let configurableSetting: VariableConstraintsSettingsType

        /// Стиль скругления углов
        let roundCornersStyle: RoundCornersStyle

        /// Отступы
        let insets: UIEdgeInsets

        /// Расстояние между textField и label
        let horizontalOffset: CGFloat

        init(
            configurableSetting: VariableConstraintsSettingsType,
            roundCornersStyle: RoundCornersStyle,
            insets: UIEdgeInsets,
            horizontalOffset: CGFloat
        ) {
            self.configurableSetting = configurableSetting
            self.roundCornersStyle = roundCornersStyle
            self.insets = insets
            self.horizontalOffset = horizontalOffset
        }
    }
}
