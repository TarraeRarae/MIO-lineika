//
//  TitleTableHeader.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 22.12.2022.
//

import UIKit
import SnapKit

final class TitleTableHeader: UITableViewHeaderFooterView {

    // MARK: - Constants

    private enum Constants {
    
        enum TitleLabel {
            static let lineHeight: CGFloat = 26
        }

        enum SubtitleLabel {
            static let insets = UIEdgeInsets(top: 20, left: 0, bottom: 26, right: 0)
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

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configurable Item

extension TitleTableHeader: ConfigurableItem {

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

private extension TitleTableHeader {

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
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.SubtitleLabel.insets.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
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

extension TitleTableHeader {

    struct Configuration {

        /// Заголовок
        let title: String

        /// Подзаголовок
        let subtitle: String
    }
}
