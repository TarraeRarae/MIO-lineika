//
//  ConfigurableItem.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

protocol ConfigurableItem: AnyObject {
    func configure(_ params: Any)
}
