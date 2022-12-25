//
//  MainSection.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 24.12.2022.
//

import UIKit

enum MainSection {

    // MARK: - Cases

    case main

    // MARK: - Internal properties

    var headerModel: TitleCollectionHeader.Configuration {
        switch self {
        case .main:
            return TitleCollectionHeader.Configuration(
                title: L10n.MainScreen.Header.title,
                subtitle: L10n.MainScreen.Header.subtitle
            )
        }
    }

    // MARK: - Internal methods

    func getSectionSize(width: CGFloat) -> CGSize {
        let sectionHeader = TitleCollectionHeader()
        sectionHeader.configure(headerModel)
        sectionHeader.layoutIfNeeded()
        
        let targetSize = CGSize(
            width: width,
            height: UIView.layoutFittingCompressedSize.height
        )
        let height = sectionHeader.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        ).height
        
        return CGSize(width: width, height: height)
    }

}
