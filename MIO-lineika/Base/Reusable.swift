//
//  Reusable.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
