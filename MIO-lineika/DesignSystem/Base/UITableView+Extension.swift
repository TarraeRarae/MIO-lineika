//
//  UITableView+Extension.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit

extension UITableView {

    func register<T: Reusable>(cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    func register<T: UITableViewCell>(cellClass: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func register(_ cells: TableViewCell.Type...) {
        cells.forEach { cell in
            register(cellClass: cell)
        }
    }

    func registerCells(_ models: AnyTableViewCellModelProtocol.Type...) {
        models.forEach {
            register(cellType: $0.viewClass)
        }
    }

    func dequeueReusableCell(
        withModel model: AnyTableViewCellModelProtocol,
        for indexPath: IndexPath
    ) -> UITableViewCell {
        return dequeueReusableCell(
            withIdentifier: type(of: model).reuseIdentifier,
            for: indexPath
        )
    }

}
