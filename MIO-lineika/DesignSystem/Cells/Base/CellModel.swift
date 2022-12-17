//
//  CellModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit

protocol CellModelProtocol {
    var cellType: CellType { get }

    associatedtype CellType = TableViewCell
}
