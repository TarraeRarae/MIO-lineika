//
//  ConfigurableCollectionTextCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 29.12.2022.
//

import UIKit
import SnapKit

final class ConfigurableCollectionTextCell: CollectionViewCell {

    // MARK: - Constants

    private enum Constants {

        enum TitleLabel {
            static let insets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        }

        enum StackView {
            static let insets = UIEdgeInsets(top: 8, left: 27, bottom: 0, right: 25)
            static let height: CGFloat = 16
        }
    }

    // MARK: - Private properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
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
    
        for text in configuration.texts {
            let label = makeLabel(with: text)
            stackView.addArrangedSubview(label)
        }
    }
}

// MARK: - Private methods

private extension ConfigurableCollectionTextCell {

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
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.TitleLabel.insets.left)
            $0.trailing.equalToSuperview().inset(Constants.TitleLabel.insets.right)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.StackView.insets.top)
            $0.leading.equalToSuperview().offset(Constants.StackView.insets.left)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(Constants.StackView.height)
            $0.right.equalToSuperview().inset(Constants.StackView.insets.right)
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

private extension ConfigurableCollectionTextCell {

    func makeLabel(with text: String) -> UILabel {
        let label = UILabel()

        label.textColor = DesignManager.shared.theme[.text(.primary)]
        label.font = FontFamily.Nunito.regular.font(size: 14)
        label.numberOfLines = 0
        label.text = text

        return label
    }
}

// MARK: - Configuration

extension ConfigurableCollectionTextCell {

    struct Configuration {

        /// Уникальный идентификатор ячейки
        let uniqueId = UUID()

        /// Заголовок
        let title: String

        /// Текст для лейблов
        let texts: [String]
    }
}
