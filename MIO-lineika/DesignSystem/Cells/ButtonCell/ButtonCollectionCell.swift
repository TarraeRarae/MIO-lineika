//
//  ButtonTableCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 18.12.2022.
//

import UIKit
import SnapKit

final class ButtonCollectionCell: CollectionViewCell {

    // MARK: - Constants

    private enum Constants {
        static let height: CGFloat = 50
        static let cornerRadius: CGFloat = 30
    }

    // MARK: - Private properties

    private let button = MainButton()
    
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
        button.configure(configuration.buttonConfiguration)

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

    // MARK: - Internal properties

    func setIsButtonEnabled(state: Bool) {
        button.setButtonEnabledState(state: state)
    }
}

// MARK: - Private methods

private extension ButtonCollectionCell {

    func commonInit() {
        setupSubviews()
        applyTheme()
    }

    func setupSubviews() {
        contentView.addSubview(button)
    }

    func setupLayouts(with insets: UIEdgeInsets) {
        button.snp.makeConstraints {
            $0.top.equalToSuperview().offset(insets.top)
            $0.leading.equalToSuperview().offset(insets.left)
            $0.right.equalToSuperview().inset(insets.right)
            $0.bottom.equalToSuperview().inset(insets.bottom)
            $0.height.equalTo(Constants.height)
        }
    }

    func applyTheme() {
        contentView.backgroundColor = .clear
        backgroundColor = DesignManager.shared.theme[.background(.cell)]
    }
}

// MARK: - Configuration

extension ButtonCollectionCell {

    struct Configuration {

        enum RoundCornersStyle {
            case top
            case bottom
            case full
            case none
        }

        /// Уникальный идентификатор модели ячейки
        let uniqueId = UUID()

        /// Модель конфигурации для кнопки
        let buttonConfiguration: MainButton.Configuration

        /// Стиль скругления углов
        let roundCornersStyle: RoundCornersStyle

        /// Отступы
        let insets: UIEdgeInsets    }
}
