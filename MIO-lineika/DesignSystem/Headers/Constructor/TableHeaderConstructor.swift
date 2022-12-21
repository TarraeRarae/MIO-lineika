//
//  TableHeaderConstructor.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 22.12.2022.
//

import UIKit

final class TableHeaderConstructor {

    // MARK: - Static properties

    static let shared = TableHeaderConstructor()

    // MARK: - Internal properties

    func makeTitleTableHeader(
        title: String,
        subtitle: String
    ) -> TitleTableHeader {
        let configuration = TitleTableHeader.Configuration(title: title, subtitle: subtitle)
        let header = TitleTableHeader()
        header.configure(configuration)

        return header
    }
}
