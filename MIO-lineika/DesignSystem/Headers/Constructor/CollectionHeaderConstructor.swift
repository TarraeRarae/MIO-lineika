//
//  TableHeaderConstructor.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 22.12.2022.
//

import UIKit

final class CollectionHeaderConstructor {

    // MARK: - Static properties

    static let shared = CollectionHeaderConstructor()

    // MARK: - Internal properties

    func makeTitleTableHeader(
        title: String,
        subtitle: String
    ) -> TitleCollectionHeader {
        let configuration = TitleCollectionHeader.Configuration(title: title, subtitle: subtitle)
        let header = TitleCollectionHeader()
        header.configure(configuration)

        return header
    }
}
