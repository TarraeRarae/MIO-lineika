//
//  ConstraintsSystemCollectionCellProtocols.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 30.12.2022.
//

import Foundation

protocol ConstraintsSystemCollectionCellViewModelOuput: AnyObject {
    @discardableResult
    func valueDidChange(text: String, for tag: Int) -> (Bool, String?)
    func showAlert(title: String, description: String?)
}

protocol ConstraintsSystemCollectionCellViewModelDelegate: AnyObject {
    func constraintsSystemValueDidChange(value: Int, for index: Int)
    func showAlert(title: String, description: String?)
    func clearConstraintsValue(for index: Int)
}
