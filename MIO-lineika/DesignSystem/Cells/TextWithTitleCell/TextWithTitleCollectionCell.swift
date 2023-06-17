//
//  TextWithTitleCollectionCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 10.01.2023.
//

import UIKit
import SnapKit

final class TextWithTitleCollectionCell: CollectionViewCell {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 30
        static let defaultCornerRadius: CGFloat = 0
    }

    // MARK: - Private properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
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

        titleLabel.text = configuration.title
        subtitleLabel.text = configuration.subtitle

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

        setupLayouts(with: configuration.insets)
    }
}

// MARK: - Private methods

private extension TextWithTitleCollectionCell {

    func commonInit() {
        setupSubviews()
        applyTheme()
    }

    func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }

    func setupLayouts(with insets: UIEdgeInsets) {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(insets.top)
            $0.leading.equalToSuperview().offset(insets.left)
            $0.trailing.equalToSuperview().inset(insets.right)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(insets.left)
            $0.trailing.equalToSuperview().inset(insets.right)
            $0.bottom.equalToSuperview().inset(insets.bottom)
        }
    }

    func applyTheme() {
        contentView.backgroundColor = .clear
        backgroundColor = DesignManager.shared.theme[.background(.cell)]
        titleLabel.textColor = DesignManager.shared.theme[.text(.primary)]
        titleLabel.font = FontFamily.Nunito.semiBold.font(size: 20)

        subtitleLabel.textColor = DesignManager.shared.theme[.text(.primary)]
        subtitleLabel.font = FontFamily.Nunito.medium.font(size: 16)
    }
}

// MARK: - Configuration

extension TextWithTitleCollectionCell {

    struct Configuration {

        enum RoundCornersStyle {
            case top
            case bottom
            case full
            case none
        }
    
        /// Уникальный идентификатор модели ячейки
        let uniqueId = UUID()

        /// Заголовой
        let title: String

        /// Подзаголовок
        let subtitle: String

        /// Стиль скругления углов
        let roundCornersStyle: RoundCornersStyle

        /// Отступы для заголовка
        let insets: UIEdgeInsets
    }
}
