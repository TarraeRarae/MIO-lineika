//
//  ConstraintsSystemCollectionCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 30.12.2022.
//

import UIKit
import SnapKit

final class ConstraintsSystemCollectionCell: CollectionViewCell {

    // MARK: - Constants

    private enum Constants {
        static let maxTextLength: Int = 2

        enum TitleLabel {
            static let insets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        }

        enum StackView {
            static let insets = UIEdgeInsets(top: 17, left: 10, bottom: 17, right: 25)
        }

        enum ImageView {
            static let width: CGFloat = 16
            static let insets = UIEdgeInsets(top: 8, left: 25, bottom: 0, right: 25)
        }
    }

    // MARK: - Internal properties

    var viewModel: ConstraintsSystemCollectionCellViewModelOuput?

    // MARK: - Private properties

    private var textFieldMatrix = [[UITextField]]()

    private let bracketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = Asset.Brackets.figuralBracket.image
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 16
        return stackView
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

    // MARK: - Configurable Item

    override func configure(_ params: Any) {
        guard let configuration = params as? Configuration else { return }

        titleLabel.text = configuration.titleText

        for index in 0..<configuration.constraints {
            let stackView = makeHorizontalStackView(variables: configuration.variables, with: index)
            verticalStackView.addArrangedSubview(stackView)
        }
    }
}

// MARK: - Private methods

private extension ConstraintsSystemCollectionCell {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        applyTheme()
    }

    func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(bracketImageView)
        contentView.addSubview(verticalStackView)
    }

    func setupLayouts() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.TitleLabel.insets.left)
            $0.right.equalToSuperview().inset(Constants.TitleLabel.insets.right)
        }

        bracketImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        bracketImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.ImageView.insets.top)
            $0.leading.equalToSuperview().offset(Constants.ImageView.insets.left)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(Constants.ImageView.width)
        }

        verticalStackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.StackView.insets.top)
            $0.leading.equalTo(bracketImageView.snp.trailing).offset(Constants.StackView.insets.left)
            $0.bottom.equalToSuperview().inset(Constants.StackView.insets.bottom)
            $0.trailing.lessThanOrEqualToSuperview().inset(Constants.StackView.insets.right)
        }
    }

    func applyTheme() {
        contentView.backgroundColor = .clear
        backgroundColor = DesignManager.shared.theme[.background(.cell)]

        titleLabel.textColor = DesignManager.shared.theme[.text(.primary)]
        titleLabel.font = FontFamily.Nunito.medium.font(size: 18)
    }
}

// MARK: - Cell Constructor

private extension ConstraintsSystemCollectionCell {

    func makeHorizontalStackView(variables: Int, with tag: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .clear

        for index in 1...variables {
            var labelText = ""
            if index == variables {
                labelText = "x\(index)"
            } else {
                labelText = "x\(index) +"
            }
            let textField = makeTextFieldWithLabel(
                configuration: BottomLineTextFieldWithLabel.Configuration(
                    text: labelText,
                    textFieldConfiguration: BottomLineTextField.Configuration(
                        text: "0"
                    )
                )
            )
            textField.textField.tag = 10 * tag + index - 1
            textField.delegate = self

            stackView.addArrangedSubview(textField)
        }

        let label = makeLabel(with: "≤")
        stackView.addArrangedSubview(label)

        let resultTextField = BottomLineTextField()
        let resultTextFieldConfiguration = BottomLineTextField.Configuration(text: "0")
        resultTextField.configure(resultTextFieldConfiguration)

        resultTextField.snp.makeConstraints {
            $0.width.equalTo(27)
        }

        resultTextField.tag = 10 * tag + variables
        resultTextField.delegate = self

        stackView.addArrangedSubview(resultTextField)

        stackView.sizeToFit()

        return stackView
    }

    func makeLabel(with text: String) -> UILabel {
        let label = UILabel()

        label.textColor = DesignManager.shared.theme[.text(.primary)]
        label.font = FontFamily.Nunito.medium.font(size: 14)
        label.text = text

        return label
    }

    func makeTextFieldWithLabel(
        configuration: BottomLineTextFieldWithLabel.Configuration
    ) -> BottomLineTextFieldWithLabel {
        let textField = BottomLineTextFieldWithLabel()

        textField.configure(configuration)
        textField.textField.delegate = self

        return textField
    }
}

extension ConstraintsSystemCollectionCell: UITextFieldDelegate {

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
        if let result = viewModel?.valueDidChange(text: text, for: textField.tag),
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
            viewModel?.valueDidChange(text: newString, for: textField.tag)
        }

        return result
    }
}

// MARK: - Configuration

extension ConstraintsSystemCollectionCell {

    struct Configuration {

        /// Уникальный идентификатор ячейки
        let uniqueId = UUID()

        /// Текст заголовка
        let titleText: String

        /// Количество переменных
        let variables: Int

        /// Количество ограничений
        let constraints: Int
    }
}
