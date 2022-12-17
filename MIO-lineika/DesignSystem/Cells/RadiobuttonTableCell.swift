//
//  RadiobuttonTableCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit
import SnapKit

final class RadiobuttonTableCell: TableViewCell {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 30
        static let defaultCornerRadius: CGFloat = 0
        static let disabledContentViewAlpha: CGFloat = 0.4
        static let enabledContentViewAlpha: CGFloat = 1

        enum Radiobutton {
            static let size = CGSize(width: 16, height: 16)
            static let leadingOffset: CGFloat = 25
        }

        enum Title {
            static let insets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 10)
        }
    }

    // MARK: - Private properties

    private let radiobuttonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = Asset.Radiobutton.radiobuttonDisabled.image
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()

    var uniqueId: UUID?

    private var selectionAction: ((UUID) -> Void)?

    private var isEnabled: Bool = true {
        didSet {
            contentView.alpha = isEnabled ? Constants.enabledContentViewAlpha:  Constants.disabledContentViewAlpha
        }
    }

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
        radiobuttonImage.image = Asset.Radiobutton.radiobuttonDisabled.image
        isEnabled = true
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
        guard let configuration = params as? Configuration else {
            return
        }

        uniqueId = configuration.uniqueId

        switch configuration.configurableSetting {
        case .method(let method):
            titleLabel.text = method.title
        case .optimization(let optimization):
            titleLabel.text = optimization.rawValue
        }

        isEnabled = configuration.isEnabled

        setCellSelected(configuration.isCellSelected)

        selectionAction = configuration.selectionAction

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

    // MARK: - Internal methods

    func setCellSelected(_ isSelected: Bool) {
        if !isEnabled { return }
        if isSelected {
            UIView.transition(
                with: radiobuttonImage,
                duration: 0.2,
                options: .transitionCrossDissolve
            ) { [weak self] in
                self?.radiobuttonImage.image = Asset.Radiobutton.radiobuttonEnabled.image
            }
            return
        }
        UIView.transition(
            with: radiobuttonImage,
            duration: 0.2,
            options: .transitionCrossDissolve
        ) { [weak self] in
            self?.radiobuttonImage.image = Asset.Radiobutton.radiobuttonDisabled.image
        }
    }
}

// MARK: - Private methods

private extension RadiobuttonTableCell {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        setupGestureRecognizers()
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

    func setupGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(cellDidSelect)
        )
        addGestureRecognizer(tapGestureRecognizer)
    }

    func applyTheme() {
        contentView.backgroundColor = .clear
        backgroundColor = DesignManager.shared.theme[.background(.tableCell)]
        titleLabel.textColor = DesignManager.shared.theme[.text(.primary)]
    }

    @objc
    func cellDidSelect() {
        guard let uuid = uniqueId, isEnabled
        else { return }

        selectionAction?(uuid)
    }
}

// MARK: - Configuration

extension RadiobuttonTableCell {

    struct Configuration: CellModelProtocol {

        enum RoundCornersStyle {
            case top
            case bottom
            case full
            case none
        }

        enum ConfigurableSetting {
            case method(MethodType)
            case optimization(OptimizationType)
        }

        /// Тип ячейки для конфигурации
        let cellType = RadiobuttonTableCell.self

        /// Уникальный идентификатор ячейки
        let uniqueId = UUID()

        /// Настройка, за которую отвечает ячейка
        var configurableSetting: ConfigurableSetting

        /// Состояние radiobutton
        var isCellSelected: Bool

        ///
        let isEnabled: Bool

        /// Стиль скругления углов
        let roundCornersStyle: RoundCornersStyle

        /// Замыкание при выборе ячейки
        let selectionAction: (UUID) -> Void

        init(
            configurableSetting: ConfigurableSetting,
            isCellSelected: Bool = false,
            isEnabled: Bool,
            roundCornersStyle: RoundCornersStyle,
            selectionAction: @escaping (UUID) -> Void
        ) {
            self.configurableSetting = configurableSetting
            self.isCellSelected = isCellSelected
            self.isEnabled = isEnabled
            self.roundCornersStyle = roundCornersStyle
            self.selectionAction = selectionAction
        }
    }
}
