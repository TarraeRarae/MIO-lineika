//
//  RadiobuttonCellProtocols.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import Foundation

protocol RadiobuttonCellViewModelInput: AnyObject {
    var uniqueId: UUID { get }

    func deselectCell()
}

protocol RadiobuttonCellViewModelOutput: AnyObject {
    func radiobuttonDidSelect()
}

protocol RadiobuttonCellViewModelDelegate: AnyObject {
    func didSelectedRadiobutton(
        with uniquedId: UUID,
        for settingType: RadiobuttonTableCell.Configuration.ConfigurableSetting
    )
}
