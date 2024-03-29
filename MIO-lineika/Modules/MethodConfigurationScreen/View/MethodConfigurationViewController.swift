//
//  MethodConfigurationViewController.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 26.12.2022.
//

import UIKit

final class MethodConfigurationViewController: BaseController {

    // MARK: - Constants

    private enum Constants {
        static let horizontalOffset: CGFloat = 40
        static let bottomInset: CGFloat = 19
    }

    // MARK: - Private properties

    private let viewModel: MethodConfigurationViewModelProtocol

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
        MethodConfigurationSection,
        MethodConfigurationSectionItem
    >?

    // MARK: - Initializers

    init(viewModel: MethodConfigurationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        title = viewModel.getTitle()
    }
}

// MARK: - Private methods

private extension MethodConfigurationViewController {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        setupDataSource()
        setupCollectionView()
    }

    func setupSubviews() {
        view.addSubview(collectionView)
    }

    func setupLayouts() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.bottomInset)
            $0.trailing.equalToSuperview()
        }
    }

    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<
            MethodConfigurationSection,
            MethodConfigurationSectionItem
        >(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            var model: AnyCollectionViewCellModelProtocol
    
            switch itemIdentifier {
            case .divider(let viewModel):
                model = viewModel
            case .button(let viewModel):
                model = viewModel
            case .configurableText(let viewModel):
                model = viewModel
            case .funcitonInput(let viewModel):
                model = viewModel
            case .constraintsSystem(let viewModel):
                model = viewModel
            }

            let cell = collectionView.dequeueReusableCell(withModel: model, for: indexPath)

            model.configureAny(cell)
    
            return cell
        }

        dataSource?.supplementaryViewProvider = { [weak self] collectionView, elementKind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: elementKind,
                withReuseIdentifier: SubtitleCollectionHeader.reuseIdentifier,
                for: indexPath
            ) as? SubtitleCollectionHeader,
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
            SubtitleCollectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SubtitleCollectionHeader.reuseIdentifier
        )
    
        collectionView.registerCells(
            DividerCollectionCellViewModel.self,
            ButtonCollectionCellViewModel.self,
            ConfigurableCollectionTextCellViewModel.self,
            FunctionInputCollectionCellViewModel.self,
            ConstraintsSystemCollectionCellViewModel.self
        )

        collectionView.keyboardDismissMode = .onDrag
        collectionView.backgroundColor = .clear
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
}

// MARK: - MethodConfigurationViewModelDelegate

extension MethodConfigurationViewController: MethodConfigurationViewModelDelegate {
    
    func setSections(model: MethodConfigurationControllerModel) {
        var snapshot = NSDiffableDataSourceSnapshot<
            MethodConfigurationSection,
            MethodConfigurationSectionItem
        >()

        for section in model.sections {
            snapshot.appendSections([section.key])
            snapshot.appendItems(section.value, toSection: section.key)
        }

        DispatchQueue.main.async { [weak self] in
            self?.dataSource?.applySnapshotUsingReloadData(snapshot)
        }
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

// MARK: - UICollectionViewDelegate

extension MethodConfigurationViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MethodConfigurationViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        guard let section = dataSource?.sectionIdentifier(for: section) else {
            return .zero
        }

        let width = collectionView.bounds.size.width - Constants.horizontalOffset
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
        
        let cellWidth = collectionView.bounds.size.width - Constants.horizontalOffset
        let size = cellSnapshot.getCellSize(cellWidth: cellWidth)

        return size
        
    }
}
