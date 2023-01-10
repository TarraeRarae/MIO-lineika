//
//  SubtitleCollectionHeader.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 28.12.2022.
//

import UIKit
import SnapKit

final class SubtitleCollectionHeader: UICollectionReusableView {

    // MARK: - Constants

    private enum Constants {
        static let insets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

    // MARK: - Internal properties

    override var reuseIdentifier: String? {
        return String(describing: SubtitleCollectionHeader.self)
    }

    // MARK: - Private properties

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

extension SubtitleCollectionHeader: ConfigurableItem {

    func configure(_ params: Any) {
        guard let configuration = params as? Configuration else {
            return
        }
    
        subtitleLabel.text = configuration.subtitle
    }
}

// MARK: - Private methods

private extension SubtitleCollectionHeader {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        applyTheme()
    }

    func setupSubviews() {
        addSubview(subtitleLabel)
    }

    func setupLayouts() {
        subtitleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.insets.left)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Constants.insets.right)
        }
    }

    func applyTheme() {
        backgroundColor = .clear
        subtitleLabel.textColor = DesignManager.shared.theme[.text(.primary)]
        subtitleLabel.font = FontFamily.Nunito.extraLight.font(size: 15)
    }
}

// MARK: - Configuration

extension SubtitleCollectionHeader {

    struct Configuration {

        /// Уникальный идентификатор модели
        let uniqueId = UUID()

        /// Подзаголовок
        let subtitle: String
    }
}
