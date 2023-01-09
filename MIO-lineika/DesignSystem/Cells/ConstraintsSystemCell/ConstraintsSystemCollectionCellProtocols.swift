//
//  ConstraintsSystemCollectionCellProtocols.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 30.12.2022.
//

import Foundation

protocol ConstraintsSystemCollectionCellViewModelOuput: AnyObject {
    @discardableResult
    func valueDidChange(text: String) -> (Bool, String?)
    func showAlert(title: String, description: String?)
}

protocol ConstraintsSystemCollectionCellViewModelDelegate: AnyObject {
    func constraintsSystemValueDidChange(text: String)
    func showAlert(title: String, description: String?)
}
