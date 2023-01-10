//
//  MethodConfigurationSection.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 26.12.2022.
//

import UIKit

enum MethodConfigurationSection {
    
    // MARK: - Cases

    case main

    // MARK: - Internal properties

    var headerModel: SubtitleCollectionHeader.Configuration {
        switch self {
        case .main:
            return SubtitleCollectionHeader.Configuration(
                subtitle: L10n.MethodConfigurationScreen.Header.subtitle
            )
        }
    }

    // MARK: - Internal methods

    func getSectionSize(width: CGFloat) -> CGSize {
        let sectionHeader = SubtitleCollectionHeader()
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
