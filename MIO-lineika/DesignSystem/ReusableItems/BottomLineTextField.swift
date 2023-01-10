//
//  MainTextField.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import UIKit
import SnapKit

final class BottomLineTextField: UITextField {

    // MARK: - Constants

    private enum Constants {

        enum BottomBorder {
            static let height: CGFloat = 1.5
        }
    }

    // MARK: - Private properties

    private let bottomLine: UIView = {
        let view = UIView()
        return view
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

// MARK: - ConfigurableItem

extension BottomLineTextField: ConfigurableItem {

    func configure(_ params: Any) {
        guard let configuration = params as? BottomLineTextField.Configuration else { return }
        text = configuration.text
    }
}

// MARK: - Private methods

private extension BottomLineTextField {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        applyTheme()
    }

    func setupSubviews() {
        addSubview(bottomLine)
    }

    func setupLayouts() {
        bottomLine.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(Constants.BottomBorder.height)
        }
    }

    func applyTheme() {
        bottomLine.backgroundColor = DesignManager.shared.theme[.background(.textFieldBorder)]
        backgroundColor = .clear
        textColor = DesignManager.shared.theme[.text(.secondary)]
        textAlignment = .center
        keyboardType = .numberPad
    }
}

// MARK: - Configuration

extension BottomLineTextField {

    struct Configuration {

        /// Текст
        let text: String

        init(text: String) {
            self.text = text
        }
    }
}
