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
        viewModel.delegate = self
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }

    override func applyTheme() {
        view.backgroundColor = DesignManager.shared.theme[.background(.main)]
    }
}

// MARK: - Private methods

private extension MainViewController {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        setupTableView()
        setupGestures()
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
        tableView.showsVerticalScrollIndicator = false

        tableView.registerCells(
            RadiobuttonTableCellViewModel.self,
            TitleTableCellViewModel.self,
            DividerTableCellViewModel.self,
            VariablesAndConstraintsTableCellViewModel.self,
            ButtonTableCellViewModel.self
        )

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
    }

    func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
    }

    @objc
    func viewDidTap() {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = viewModel.cellViewModelFor(indexPath: indexPath)
        else {
            fatalError("Unexpected error for \(indexPath) in MainViewController (cell doesn't exist")
        }

        let cell = tableView.dequeueReusableCell(withModel: cellModel, for: indexPath)
        cell.selectionStyle = .none

        cellModel.configureAny(cell)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.headerFor(section: section)
    }
}

// MARK: - MainViewModelDelegate

extension MainViewController: MainViewModelDelegate {

    func reloadData() {
        tableView.reloadData()
    }

    func showAlert(title: String, description: String?) {
        let alert = UIAlertController(
            title: title,
            message: description,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: L10n.Alert.Action.ok, style: .default)
        alert.addAction(okAction)

        present(alert, animated: true)
    }
}
