//
//  BottomLineTextFieldWithLabel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 30.12.2022.
//

import UIKit
import SnapKit

final class BottomLineTextFieldWithLabel: UIView {

    // MARK: - Constants

    private enum Constants {
        static let horizontalInset: CGFloat = 6

        enum TextField {
            static let width: CGFloat = 27
            static let height: CGFloat = 24
        }
    }

    // MARK: - Internal properties

    weak var delegate: UITextFieldDelegate? = nil {
        didSet {
            bottomLineTextField.delegate = delegate
        }
    }

    var textField: UITextField {
        return bottomLineTextField
    }

    var attributedPlaceholder: NSAttributedString? = nil {
        didSet {
            textField.attributedPlaceholder = attributedPlaceholder
        }
    }

    // MARK: - Private properties

    private let bottomLineTextField = BottomLineTextField()

    private let textLabel: UILabel = {
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
}

// MARK: - ConfigurableItem

extension BottomLineTextFieldWithLabel: ConfigurableItem {

    func configure(_ params: Any) {
        guard let configuration = params as? Configuration else { return }

        textLabel.text = configuration.text
        bottomLineTextField.configure(configuration.textFieldConfiguration)
    }
}

// MARK: - Private methods

private extension BottomLineTextFieldWithLabel {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        applyTheme()
    }

    func setupSubviews() {
        addSubview(bottomLineTextField)
        addSubview(textLabel)
    }

    func setupLayouts() {
        bottomLineTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(Constants.TextField.width)
            $0.height.equalTo(Constants.TextField.height)
        }

        textLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(bottomLineTextField.snp.trailing).offset(Constants.horizontalInset)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }

    func applyTheme() {
        backgroundColor = .clear
        textLabel.textColor = DesignManager.shared.theme[.text(.primary)]
        textLabel.font = FontFamily.Nunito.medium.font(size: 14)
    }
}

// MARK: - Configuration

extension BottomLineTextFieldWithLabel {

    struct Configuration {

        /// Уникальный идентификатор
        let uniqueId = UUID()

        /// Текст лейбла
        let text: String

        /// Конфигурация textField
        let textFieldConfiguration: BottomLineTextField.Configuration
    }
}
