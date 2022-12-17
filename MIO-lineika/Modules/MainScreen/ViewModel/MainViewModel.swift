//
//  MainViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 15.12.2022.
//

import UIKit

protocol MainViewModelProtocol: AnyObject {
    var delegate: MainViewModelDelegate? { get set }

    func numberOfRows(in section: Int) -> Int
    func cellViewModelFor(indexPath: IndexPath) -> TableCellViewModelProtocol?
}

protocol MainViewModelDelegate: AnyObject {
    func reloadData()
}

final class MainViewModel: MainViewModelProtocol {

    // MARK: - Internal properties

    weak var delegate: MainViewModelDelegate?

    // MARK: - Private properties

    private var cellViewModels = [TableCellViewModelProtocol]()

    // MARK: - Initializers

    init() {
        setupCellModels()
    }

    // MARK: - Internal methods

    func numberOfRows(in section: Int) -> Int {
        if section != 0 { return 0 }
        return cellViewModels.count
    }

    func cellViewModelFor(indexPath: IndexPath) -> TableCellViewModelProtocol? {
        if indexPath.section != 0 { return nil }
        return indexPath.row <= cellViewModels.count ? cellViewModels[indexPath.row] : nil
    }
}

// MARK: - Private methods

private extension MainViewModel {

    func setupCellModels() {
        delegate?.reloadData()
    }

    func setCellSelected(with uuid: UUID) {
        cellViewModels.forEach { model in
//            if model
        }
    }
}
