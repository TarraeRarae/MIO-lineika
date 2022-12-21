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
            static let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }

        enum SubtitleLabel {
            static let insets = UIEdgeInsets(top: 20, left: 20, bottom: 26, right: 20)
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
        
        titleLabel.text = configuration.title
        subtitleLabel.text = configuration.subtitle
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
