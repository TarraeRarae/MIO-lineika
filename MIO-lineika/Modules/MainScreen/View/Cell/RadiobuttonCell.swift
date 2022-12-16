//
//  RadiobuttonsCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit
import SnapKit

final class RadiobuttonCell: UITableViewCell {

    // MARK: - Constants

    private enum Constants {
        static let cellId = String(describing: RadiobuttonCell.self)

        enum Radiobutton {
            static let size = CGSize(width: 16, height: 16)
            static let leadingOffset: CGFloat = 25
        }

        enum Title {
            static let insets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 10)
        }
    }

    // MARK: - Static properties

    static let cellId = Constants.cellId

    // MARK: - Private properties

    private let radiobuttonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        return label
    }()

    private var isEnabled: Bool = false {
        didSet {
            if isEnabled {
                radiobuttonImage.image = Asset.Radiobutton.radiobuttonEnabled.image
                return
            }
            radiobuttonImage.image = Asset.Radiobutton.radiobuttonEnabled.image
        }
    }

    private var uniqueId: UUID?
    private var selectionAction: ((UUID) -> Void)?

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

    // MARK: - Internal methods

    func didSelect(indexPath: IndexPath) {
        guard let uuid = uniqueId else { return }

        selectionAction?(uuid)
    }
}

// MARK: - Private methods

private extension RadiobuttonCell {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        applyTheme()
    }
    
    func setupSubviews() {
        contentView.addSubview(radiobuttonImage)
        contentView.addSubview(titleLabel)
    }

    func setupLayouts() {
        radiobuttonImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(Constants.Radiobutton.size.height)
            $0.width.equalTo(Constants.Radiobutton.size.width)
            $0.leading.equalToSuperview().offset(Constants.Radiobutton.leadingOffset)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.Title.insets.top)
            $0.leading.equalTo(radiobuttonImage.snp.trailing).offset(Constants.Title.insets.left)
            $0.bottom.equalToSuperview().inset(Constants.Title.insets.bottom)
            $0.trailing.equalToSuperview().inset(Constants.Title.insets.right)
        }
    }

    func applyTheme() {
        titleLabel.textColor = DesignManager.shared.theme.color(.text(.primary))
    }
}

// MARK: - ConfigurableItem

extension RadiobuttonCell: ConfigurableItem {

    func configure(_ params: Any) {
        guard let configuration = params as? Configuration else {
            return
        }

        uniqueId = configuration.uniqueId
        titleLabel.text = configuration.title
        isEnabled = configuration.isEnabled
        selectionAction = configuration.selectionAction
    }
}


// MARK: - Configuration

extension RadiobuttonCell {

    struct Configuration {

        /// Уникальный идентификатор ячейки
        let uniqueId = UUID()

        /// Состояние radiobutton
        let isEnabled: Bool

        /// Текст справа от кнопки
        let title: String

        /// Замыкание при выборе ячейки
        let selectionAction: (UUID) -> Void
    }
}
