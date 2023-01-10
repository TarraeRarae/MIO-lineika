//
//  FunctionInputCollectionCellProtocols.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 30.12.2022.
//

protocol FunctionInputCollectionCellViewModelOutput: AnyObject {
    @discardableResult
    func valueDidChange(text: String, for tag: Int) -> (Bool, String?)
    func showAlert(title: String, description: String?)
}

protocol FunctionInputCollectionCellViewModelDelegate: AnyObject {
    func showAlert(title: String, description: String?)
    func functionValueDidChange(value: Int, for index: Int)
    func clearFunctionValue(for index: Int)
}
