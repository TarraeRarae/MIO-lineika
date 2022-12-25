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
        static let horizontalOffset: CGFloat = 40
    }

    // MARK: - Private properties

    private let viewModel: MainViewModelProtocol

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumLineSpacing = .zero
        layout.itemSize = UICollectionViewFlowLayout.automaticSize

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        return collectionView
    }()

    private var dataSource: UICollectionViewDiffableDataSource<
        MainSection,
        MainSectionItem
    >?

    // MARK: - Initializers

    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
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
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
        setupDataSource()
        setupCollectionView()
        setupGestures()
    }

    func setupSubviews() {
        view.addSubview(collectionView)
    }

    func setupLayouts() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }

    func setupDataSource() {
        collectionView.delegate = self

        dataSource = UICollectionViewDiffableDataSource<
            MainSection,
            MainSectionItem
        >(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            var model: AnyCollectionViewCellModelProtocol
    
            switch itemIdentifier {
            case .title(let viewModel):
                model = viewModel
            case .radiobutton(let viewModel):
                model = viewModel
            case .divider(let viewModel):
                model = viewModel
            case .variablesConstraints(let viewModel):
                model = viewModel
            case .button(let viewModel):
                model = viewModel
            }

            let cell = collectionView.dequeueReusableCell(withModel: model, for: indexPath)

            model.configureAny(cell)
    
            return cell
        }

        dataSource?.supplementaryViewProvider = { [weak self] collectionView, elementKind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: elementKind,
                withReuseIdentifier: TitleCollectionHeader.reuseIdentifier,
                for: indexPath
            ) as? TitleCollectionHeader,
                  let section = self?.dataSource?.sectionIdentifier(for: indexPath.section)
            else { return UICollectionReusableView() }
    
            let headerModel = section.headerModel
            header.configure(headerModel)

            return header
        }

    }

    func setupCollectionView() {
        collectionView.showsVerticalScrollIndicator = false

        collectionView.layer.shadowColor = DesignManager.shared.theme[.background(.shadow)].cgColor
        collectionView.layer.shadowOffset = CGSize(width: 500, height: 10)
        collectionView.layer.shadowRadius = 10
        collectionView.layer.shadowOpacity = 0.12

        collectionView.register(
            TitleCollectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleCollectionHeader.reuseIdentifier
        )
    
        collectionView.registerCells(
            RadiobuttonTableCellViewModel.self,
            TitleTableCellViewModel.self,
            DividerTableCellViewModel.self,
            VariablesAndConstraintsTableCellViewModel.self,
            ButtonTableCellViewModel.self
        )

        collectionView.backgroundColor = .clear
        collectionView.dataSource = dataSource
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

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        guard let section = dataSource?.sectionIdentifier(for: section) else {
            return .zero
        }

        let width = collectionView.bounds.size.width - 40
        let size = section.getSectionSize(width: width)

        return size
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let cellSnapshot = dataSource?.itemIdentifier(for: indexPath)
        else { return .zero }
        
        let cellWidth = collectionView.bounds.size.width - 40
        let size = cellSnapshot.getCellSize(cellWidth: cellWidth)

        return size
        
    }
}

// MARK: - MainViewModelDelegate

extension MainViewController: MainViewModelDelegate {

    func setSections(model: MainViewControllerModel) {
        var snapshot = NSDiffableDataSourceSnapshot<
            MainSection,
            MainSectionItem
        >()
    
        for section in model.sections {
            snapshot.appendSections([section.key])
            snapshot.appendItems(section.value, toSection: section.key)
        }

        DispatchQueue.main.async {
            self.dataSource?.applySnapshotUsingReloadData(snapshot)
        }
    }

    func reloadData() {
        collectionView.reloadData()
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
