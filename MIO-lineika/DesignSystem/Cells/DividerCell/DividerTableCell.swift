//
//  DividerTableCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit
import SnapKit

final class DividerTableCell: TableViewCell {

    // MARK: - Constants

    private enum Constants {

        enum Divider {
            static let height: CGFloat = 1
            static let topOffset: CGFloat = 14
        }
    }

    // MARK: - Private properties

    private let dividerView: UIView = {
        let view = UIView()
        return view
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
        dividerView.removeConstraints(dividerView.constraints)
    }

    //  MARK: - Configurable item

    override func configure(_ params: Any) {
        guard let configuration = params as? Configuration
        else { return }

        setupLayouts(with: configuration.dividerStyle)
    }
}

// MARK: - Private methods

private extension DividerTableCell {

    func commonInit() {
        setupSubviews()
        applyTheme()
    }

    func setupSubviews() {
        contentView.addSubview(dividerView)
    }

    func setupLayouts(with dividerStyle: Configuration.DividerStyle) {
        switch dividerStyle {
        case .fullWidth:
            dividerView.snp.makeConstraints {
                $0.top.equalToSuperview().offset(Constants.Divider.topOffset)
                $0.height.equalTo(Constants.Divider.height)
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
        }
    }

    func applyTheme() {
        dividerView.backgroundColor = DesignManager.shared.theme[.background(.divider)]
    }
}

// MARK: - Configuration

extension DividerTableCell {

    struct Configuration {

        enum DividerStyle {
            case fullWidth
        }

        /// Стиль линии-разделителя
        let dividerStyle: DividerStyle
    }
}
