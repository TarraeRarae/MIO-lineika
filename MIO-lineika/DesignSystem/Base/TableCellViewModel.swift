//
//  TableCellViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit

protocol AnyReusableCellViewModelProtocol: AnyObject {
    static var viewClass: UIView.Type { get }
    static var reuseIdentifier: String { get }
}

extension AnyReusableCellViewModelProtocol {

    private static var cellClassName: String {
        return String(describing: viewClass)
    }

    static var reuseIdentifier: String {
        return cellClassName
    }
}

protocol AnyTableViewCellModelProtocol: AnyReusableCellViewModelProtocol {
    func configureAny(_ cell: UITableViewCell)
}

protocol TableCellViewModelProtocol: AnyTableViewCellModelProtocol {
    associatedtype CellType: UITableViewCell

    func configure(_ cell: CellType)
}

extension TableCellViewModelProtocol {

    static var viewClass: UIView.Type {
        return CellType.self
    }

    func configureAny(_ cell: UITableViewCell) {
        guard let cell = cell as? CellType else {
            assertionFailure("Incorrect cell type")
            return
        }

        configure(cell)
    }
}
