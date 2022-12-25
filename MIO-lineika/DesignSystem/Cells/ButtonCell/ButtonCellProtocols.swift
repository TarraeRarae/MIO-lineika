//
//  ButtonCellProtocols.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 22.12.2022.
//

import Foundation

protocol ButtonTableCellViewModelInput: AnyObject {
    func setIsButtonEnabled(state: Bool)
}
