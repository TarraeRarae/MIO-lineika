//
//  MainViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 15.12.2022.
//

import UIKit

protocol MainViewModelProtocol: AnyObject {
    func numberOfRows(in section: Int) -> Int
    func cellFor(indexPath: IndexPath) -> TableViewCellViewModel?
}

final class MainViewModel: MainViewModelProtocol {

    func numberOfRows(in section: Int) -> Int {
        return 0
    }
    
    func cellFor(indexPath: IndexPath) -> TableViewCellViewModel? {
        return nil
    }
}
