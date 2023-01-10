//
//  RadiobuttonCollectionCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit
import SnapKit

final class RadiobuttonCollectionCell: CollectionViewCell {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 30
        static let defaultCornerRadius: CGFloat = 0
        static let disabledContentViewAlpha: CGFloat = 0.4
        static let enabledContentViewAlpha: CGFloat = 1

        enum Radiobutton {
            static let size = CGSize(width: 16, height: 16)
        }
    }

    // MARK: - Internal properties

    var viewModel: RadiobuttonCellViewModelOutput?

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

    private var isRadiobuttonSelected: Bool = false {
        didSet {
            if isRadiobuttonSelected {
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

    private var isEnabled: Bool = true {
        didSet {
            contentView.alpha = isEnabled ? Constants.enabledContentViewAlpha:  Constants.disabledContentViewAlpha
        }
    }

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

    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
            let targetSize = CGSize(
                width: layoutAttributes.frame.width,
                height: 0
            )

            layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(
                targetSize,
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            )

            return layoutAttributes
        }

    // MARK: - Configurable Item

    override func configure(_ params: Any) {
        guard let configuration = params as? Configuration else {
            return
        }

        switch configuration.configurableSetting {
        case .method(let method):
            titleLabel.text = method.title
        case .optimization(let optimization):
            titleLabel.text = optimization.rawValue
        }

        isEnabled = configuration.isEnabled

        setCellSelected(configuration.isRadiobuttonSelected)

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

        setupLayouts(
            insets: configuration.insets,
            horizontalOffset: configuration.horizontalOffset
        )
    }

    // MARK: - Internal methods

    func setCellSelected(_ isSelected: Bool = true) {
        if !isEnabled || (!isSelected && !isRadiobuttonSelected) { return }
        isRadiobuttonSelected = isSelected
    }
}

// MARK: - Private methods

private extension RadiobuttonCollectionCell {

    func commonInit() {
        setupSubviews()
        setupGestureRecognizers()
        applyTheme()
    }
    
    func setupSubviews() {
        contentView.addSubview(radiobuttonImage)
        contentView.addSubview(titleLabel)
    }

    func setupLayouts(
        insets: UIEdgeInsets,
        horizontalOffset: CGFloat
    ) {
        radiobuttonImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(insets.top)
            $0.height.equalTo(Constants.Radiobutton.size.height)
            $0.width.equalTo(Constants.Radiobutton.size.width)
            $0.bottom.equalToSuperview().inset(insets.bottom)
            $0.leading.equalToSuperview().offset(insets.left)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(insets.top)
            $0.leading.equalTo(radiobuttonImage.snp.trailing).offset(horizontalOffset)
            $0.bottom.equalToSuperview().inset(insets.bottom)
            $0.trailing.equalToSuperview().inset(insets.right)
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
        backgroundColor = DesignManager.shared.theme[.background(.cell)]
        titleLabel.textColor = DesignManager.shared.theme[.text(.primary)]
        titleLabel.font = FontFamily.Nunito.regular.font(size: 14)
    }

    @objc
    func cellDidSelect() {
        if isRadiobuttonSelected { return }

        setCellSelected()
        viewModel?.radiobuttonDidSelect()
    }
}

// MARK: - Configuration

extension RadiobuttonCollectionCell {

    struct Configuration {

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

        /// Уникальный идентификатор модели ячейки
        let uniqueId = UUID()

        /// Настройка, за которую отвечает ячейка
        var configurableSetting: ConfigurableSetting

        /// Состояние radiobutton
        var isRadiobuttonSelected: Bool

        /// Состояние ячейки
        let isEnabled: Bool

        /// Стиль скругления углов
        let roundCornersStyle: RoundCornersStyle

        /// Отступы
        let insets: UIEdgeInsets

        /// Расстояние между radiobutton и label
        let horizontalOffset: CGFloat

        init(
            configurableSetting: ConfigurableSetting,
            isRadiobuttonSelected: Bool = false,
            isEnabled: Bool,
            roundCornersStyle: RoundCornersStyle,
            insets: UIEdgeInsets,
            horizontalOffset: CGFloat
        ) {
            self.configurableSetting = configurableSetting
            self.isRadiobuttonSelected = isRadiobuttonSelected
            self.isEnabled = isEnabled
            self.roundCornersStyle = roundCornersStyle
            self.insets = insets
            self.horizontalOffset = horizontalOffset
        }
    }
}
