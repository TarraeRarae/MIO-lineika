//
//  ButtonTableCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 18.12.2022.
//

import UIKit
import SnapKit

final class ButtonTableCell: TableViewCell {

    // MARK: - Constants

    private enum Constants {}

    // MARK: - Private properties

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurable Item

    override func configure(_ params: Any) {}

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - Private methods

private extension ButtonTableCell {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        applyTheme()
    }

    func setupSubviews() {}

    func setupLayouts() {}

    func applyTheme() {}
}

// MARK: - Configuration

extension ButtonTableCell {}
