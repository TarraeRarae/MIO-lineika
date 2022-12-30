//
//  BackBarButtonView.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 28.12.2022.
//

import UIKit
import SnapKit

final class BackBarButtonView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    // MARK: - Private properties

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.Navigation.backButton.image
        return imageView
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

// MARK: - Private methods

private extension BackBarButtonView {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        applyTheme()
    }

    func setupSubviews() {
        addSubview(arrowImageView)
    }

    func setupLayouts() {
        arrowImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }

    func applyTheme() {
        backgroundColor = .clear
    }
}
