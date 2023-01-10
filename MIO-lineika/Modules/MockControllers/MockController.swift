//
//  MockController.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 25.12.2022.
//

import UIKit
import SnapKit

final class MockController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    // MARK: - Private properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.MockScreen.title
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

// MARK: - Private methods

private extension MockController {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        applyTheme()
    }

    func setupSubviews() {
        view.addSubview(titleLabel)
    }

    func setupLayouts() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.insets.left)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.bottom.equalToSuperview().inset(view.frame.height / 4)
        }
    }

    func applyTheme() {
        view.backgroundColor = DesignManager.shared.theme[.background(.main)]
        titleLabel.textColor = DesignManager.shared.theme[.text(.primary)]
        titleLabel.font = FontFamily.Nunito.bold.font(size: 24)
    }
}
