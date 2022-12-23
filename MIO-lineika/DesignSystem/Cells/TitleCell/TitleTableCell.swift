//
//  TitleTableCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit
import SnapKit

final class TitleTableCell: TableViewCell {

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

    // MARK: - Initializers

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
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

private extension TitleTableCell {

    func commonInit() {
        setupSubviews()
        applyTheme()
    }

    func setupSubviews() {
        contentView.addSubview(titleLabel)
    }

    func setupLayouts(with insets: UIEdgeInsets) {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(insets.top)
            $0.leading.equalToSuperview().offset(insets.left)
            $0.bottom.equalToSuperview().inset(insets.bottom)
            $0.trailing.equalToSuperview().inset(insets.right)
        }
    }

    func applyTheme() {
        contentView.backgroundColor = .clear
        backgroundColor = DesignManager.shared.theme[.background(.tableCell)]
        titleLabel.textColor = DesignManager.shared.theme[.text(.primary)]
        titleLabel.font = FontFamily.Nunito.semiBold.font(size: 20)
    }
}

// MARK: - Configuration

extension TitleTableCell {

    struct Configuration {

        enum RoundCornersStyle {
            case top
            case bottom
            case full
            case none
        }

        /// Отображаемый текст
        let title: String

        /// Стиль скругления углов
        let roundCornersStyle: RoundCornersStyle

        /// Отступы для заголовка
        let insets: UIEdgeInsets

        init(
            title: String,
            roundCornersStyle: RoundCornersStyle,
            insets: UIEdgeInsets
        ) {
            self.title = title
            self.roundCornersStyle = roundCornersStyle
            self.insets = insets
        }
    }
}
