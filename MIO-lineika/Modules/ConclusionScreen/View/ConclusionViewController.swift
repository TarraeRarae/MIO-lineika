//
//  ConclusionViewController.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 09.01.2023.
//

import UIKit

final class ConclusionViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let horizontalOffset: CGFloat = 40
        static let bottomInset: CGFloat = 19
    }

    // MARK: - Private properties

    private let viewModel: ConclusionViewModelProtocol

    private var dataSource: UICollectionViewDiffableDataSource<
        ConclusionSection,
        ConclusionSectionItem
    >?

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

    // MARK: - Initializers

    init(viewModel: ConclusionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension ConclusionViewController {

    func commonInit() {
        setupSubviews()
        setupLayouts()
        setupDataSources()
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

    func setupDataSources() {
        dataSource = UICollectionViewDiffableDataSource<
            ConclusionSection,
            ConclusionSectionItem
        >(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            var model: AnyCollectionViewCellModelProtocol
    
            switch itemIdentifier {
            case .button(let viewModel):
                model = viewModel
            }

            let cell = collectionView.dequeueReusableCell(withModel: model, for: indexPath)

            model.configureAny(cell)
    
            return cell
        }
    }

    func setupCollectionView() {
        collectionView.showsVerticalScrollIndicator = false

        collectionView.layer.shadowColor = DesignManager.shared.theme[.background(.shadow)].cgColor
        collectionView.layer.shadowOffset = CGSize(width: 500, height: 10)
        collectionView.layer.shadowRadius = 10
        collectionView.layer.shadowOpacity = 0.12

        collectionView.keyboardDismissMode = .onDrag
        collectionView.backgroundColor = .clear
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
}


// MARK: - ConclusionViewModelDelegate

extension ConclusionViewController: ConclusionViewModelDelegate {

    func setSections(model: ConclusionControllerModel) {
        var snapshot = NSDiffableDataSourceSnapshot<
            ConclusionSection,
            ConclusionSectionItem
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

extension ConclusionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ConclusionViewController: UICollectionViewDelegateFlowLayout {

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
