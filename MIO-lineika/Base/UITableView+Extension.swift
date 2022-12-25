//
//  UITableView+Extension.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit

extension UICollectionView {

    func register<T: Reusable>(cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func register(_ cells: CollectionViewCell.Type...) {
        cells.forEach { cell in
            register(cellClass: cell)
        }
    }

    func registerCells(_ models: AnyCollectionViewCellModelProtocol.Type...) {
        models.forEach {
            register(cellType: $0.viewClass)
        }
    }

    func dequeueReusableCell(
        withModel model: AnyCollectionViewCellModelProtocol,
        for indexPath: IndexPath
    ) -> UICollectionViewCell {
        return dequeueReusableCell(
            withReuseIdentifier: type(of: model).reuseIdentifier,
            for: indexPath
        )
    }

}
