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

protocol AnyCollectionViewCellModelProtocol: AnyReusableCellViewModelProtocol {
    func configureAny(_ cell: UICollectionViewCell)
}

protocol CollectionCellViewModelProtocol: AnyCollectionViewCellModelProtocol {
    associatedtype CellType: UICollectionViewCell

    func configure(_ cell: CellType)
}

extension CollectionCellViewModelProtocol {

    static var viewClass: UIView.Type {
        return CellType.self
    }

    func configureAny(_ cell: UICollectionViewCell) {
        guard let cell = cell as? CellType else {
            assertionFailure("Incorrect cell type")
            return
        }

        configure(cell)
    }
}
