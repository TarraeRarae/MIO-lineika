//
//  VariablesAndConstraintsCellProtocols.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

protocol VariablesAndConstraintsCollectionCellViewModelOutput: AnyObject {
    @discardableResult
    func valueDidChange(text: String) -> (Bool, String?)
    func showAlert(title: String, description: String?)
}

protocol VariablesAndConstraintsCollectionCellViewModelDelegate: AnyObject {
    func valueDidChange(for setting: VariableConstraintsSettingsType, with value: Int)
    func showAlert(title: String, description: String?)
}
