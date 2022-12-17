//
//  TextFieldTableCell.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit

final class TextFieldTableCell: TableViewCell {

    // MARK: - Constants

    private enum Constants {}

    // MARK: - Private properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        return textField
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
}

// MARK: - Private methods

private extension TextFieldTableCell {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        applyTheme()
    }

    func setupSubviews() {}

    func setupLayouts() {}

    func applyTheme() {
        
    }
}
