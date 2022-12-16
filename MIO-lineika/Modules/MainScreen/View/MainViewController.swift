//
//  ViewController.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 15.12.2022.
//

import UIKit
import SnapKit

final class MainViewController: BaseController {

    // MARK: - Constants

    private enum Constants {
        static let tableViewInsets = UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16)
    }

    // MARK: - Private properties

    private let viewModel: MainViewModelProtocol
    private let tableView: UITableView

    // MARK: - Initializers
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        self.tableView = UITableView(frame: .zero, style: .grouped)
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension MainViewController {

    func commonInit() {
        setupSubviews()
        setupLayouts()
    }

    func setupSubviews() {
        view.addSubview(tableView)
    }

    func setupLayouts() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.tableViewInsets.top)
            $0.leading.equalToSuperview().offset(Constants.tableViewInsets.left)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Constants.tableViewInsets.right)
        }
    }

    func setupTableView() {
//        tableView.register(CellClass.self, forCellReuseIdentifier: "reuseID")
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = viewModel.cellFor(indexPath: indexPath),
              let configurableCell = tableView.dequeueReusableCell(
                withIdentifier: cellModel.cellId,
                for: indexPath
              ) as? ConfigurableItem
        else {
            fatalError("Unexpected error for \(indexPath) in MainViewController (cell doesn't exist")
        }

        guard let cell = configurableCell as? UITableViewCell else {
            fatalError("Unexpected error for \(indexPath) in MainViewController (cast failed)")
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
