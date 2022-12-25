//
//  TitleTableHeader.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 22.12.2022.
//

import UIKit
import SnapKit

final class TitleCollectionHeader: UICollectionReusableView {

    override var reuseIdentifier: String? {
        return String(describing: TitleCollectionHeader.self)
    }

    // MARK: - Constants

    private enum Constants {
    
        enum TitleLabel {
            static let lineHeight: CGFloat = 26
            static let insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }

        enum SubtitleLabel {
            static let insets = UIEdgeInsets(top: 10, left: 20, bottom: 26, right: 20)
            static let lineHeight: CGFloat = 19
        }
    }

    // MARK: - Private properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private let subtitleLabel: UILabel = {
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
}

// MARK: - Configurable Item

extension TitleCollectionHeader: ConfigurableItem {

    func configure(_ params: Any) {
        guard let configuration = params as? Configuration
        else { return }
    
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.maximumLineHeight = Constants.TitleLabel.lineHeight

        let attributedTitle = NSAttributedString(
            string: configuration.title,
            attributes: [.paragraphStyle: titleParagraphStyle]
        )

        titleLabel.attributedText = attributedTitle

        let subtitleParagraphStyle = NSMutableParagraphStyle()
        subtitleParagraphStyle.maximumLineHeight = Constants.SubtitleLabel.lineHeight

        let attributedSubtitle = NSAttributedString(
            string: configuration.subtitle,
            attributes: [.paragraphStyle: subtitleParagraphStyle]
        )
    
        subtitleLabel.attributedText = attributedSubtitle
    }
}

// MARK: - Private properties

private extension TitleCollectionHeader {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        applyTheme()
    }

    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }

    func setupLayouts() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.TitleLabel.insets.left)
            $0.trailing.equalToSuperview().inset(Constants.TitleLabel.insets.right)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.SubtitleLabel.insets.top)
            $0.leading.equalToSuperview().offset(Constants.SubtitleLabel.insets.left)
            $0.trailing.equalToSuperview().inset(Constants.SubtitleLabel.insets.right)
            $0.bottom.equalToSuperview().inset(Constants.SubtitleLabel.insets.bottom)
        }
    }

    func applyTheme() {
        backgroundColor = .clear
        titleLabel.textColor = DesignManager.shared.theme[.text(.primary)]
        subtitleLabel.textColor = DesignManager.shared.theme[.text(.primary)]
        titleLabel.font = FontFamily.Nunito.bold.font(size: 24)
        subtitleLabel.font = FontFamily.Nunito.extraLight.font(size: 15)
    }
}

// MARK: - Configuration

extension TitleCollectionHeader {

    struct Configuration: Hashable {

        /// Уникальный идентификатор модели
        let uniqueId = UUID()

        /// Заголовок
        let title: String

        /// Подзаголовок
        let subtitle: String
    }
}
