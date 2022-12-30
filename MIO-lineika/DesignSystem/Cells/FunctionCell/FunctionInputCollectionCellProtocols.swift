//
//  FunctionInputCollectionCellProtocols.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 30.12.2022.
//

import Foundation

protocol FunctionInputCollectionCellViewModelOutput: AnyObject {
    func valueDidChange(text: String) -> (Bool, String?)
    func showAlert(title: String, description: String?)
}

protocol FunctionInputCollectionCellViewModelDelegate: AnyObject {
    func showAlert(title: String, description: String?)
}
