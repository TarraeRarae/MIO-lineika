//
//  FunctionCollectionCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 29.12.2022.
//

import UIKit
import SnapKit

final class FunctionInputCollectionCell: CollectionViewCell {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 30
        static let maxTextLength: Int = 2

        enum TitleLabel {
            static let insets = UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25)
        }
    
        enum StackView {
            static let insets = UIEdgeInsets(top: 8, left: 25, bottom: 0, right: 25)
            static let spacing: CGFloat = 6
            static let height: CGFloat = 24
        }
    }

    // MARK: - Internal properties

    var viewModel: FunctionInputCollectionCellViewModel?

    // MARK: - Private properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.StackView.spacing
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .clear
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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

    // MARK: - Configurable Item

    override func configure(_ params: Any) {
        guard let configuration = params as? Configuration else { return }

        titleLabel.text = configuration.title

        let functionLabel = makeLabel(with: "F =")
        stackView.addArrangedSubview(functionLabel)

        for index in 1...configuration.variables {
            var labelText = ""
            if index != configuration.variables {
                labelText = "x\(index) +"
            } else {
                labelText = "x\(index)"
            }

            let textFieldView = makeTextFieldViewWithLabel(
                text: labelText,
                textFieldModel: BottomLineTextField.Configuration(text: "0")
            )
    
            textFieldView.textField.tag = index - 1

            stackView.addArrangedSubview(textFieldView)
        }

        let optimizationLabel = makeLabel(with: "\(L10n.Arrow.right) \(configuration.optimization.rawValue)")
        stackView.addArrangedSubview(optimizationLabel)

        stackView.sizeToFit()

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

private extension FunctionInputCollectionCell {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        applyTheme()
    }

    func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackView)
    }

    func setupLayouts() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.TitleLabel.insets.top)
            $0.leading.equalToSuperview().offset(Constants.TitleLabel.insets.left)
            $0.right.equalToSuperview().inset(Constants.TitleLabel.insets.right)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.StackView.insets.top)
            $0.leading.equalToSuperview().offset(Constants.StackView.insets.left)
            $0.bottom.equalToSuperview()
            $0.right.lessThanOrEqualToSuperview().inset(Constants.StackView.insets.right)
        }
    }

    func applyTheme() {
        contentView.backgroundColor = .clear
        backgroundColor = DesignManager.shared.theme[.background(.cell)]

        titleLabel.textColor = DesignManager.shared.theme[.text(.primary)]
        titleLabel.font = FontFamily.Nunito.medium.font(size: 18)
    }
}

// MARK: - Subviews constructors

private extension FunctionInputCollectionCell {
    
    func makeLabel(with text: String) -> UILabel {
        let label = UILabel()

        label.textColor = DesignManager.shared.theme[.text(.primary)]
        label.font = FontFamily.Nunito.medium.font(size: 14)
        label.numberOfLines = 0
        label.text = text

        return label
    }

    func makeTextFieldViewWithLabel(
        text: String,
        textFieldModel: BottomLineTextField.Configuration
    ) -> BottomLineTextFieldWithLabel {
        let configuration = BottomLineTextFieldWithLabel.Configuration(
            text: text,
            textFieldConfiguration: textFieldModel
        )

        let textFieldView = BottomLineTextFieldWithLabel()
        textFieldView.configure(configuration)
        textFieldView.attributedPlaceholder = NSAttributedString(
            string: "0",
            attributes: [
                .foregroundColor: DesignManager.shared.theme[.text(.secondary)]
            ]
        )

        textFieldView.delegate = self

        return textFieldView
    }
}

extension FunctionInputCollectionCell: UITextFieldDelegate {

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

extension FunctionInputCollectionCell {

    struct Configuration {

        enum RoundCornersStyle {
            case top
            case bottom
            case full
            case none
        }

        /// Уникальный идентификатор ячейки
        let uniqueId = UUID()

        /// Заголовок
        let title: String

        /// Количество переменных
        let variables: Int

        /// Направление оптимизации
        let optimization: OptimizationType

        /// Стиль скругления углов
        let roundCornersStyle: RoundCornersStyle
    }
}
