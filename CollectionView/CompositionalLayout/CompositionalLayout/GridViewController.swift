//
//  GridViewController.swift
//  CompositionalLayout
//
//  Created by Олег Федоров on 31.03.2022.
//

import UIKit

// MARK: - GridViewController
class GridViewController: UIViewController {
    
    private enum Section {
        case main
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    private var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Grid"
        configureHierarchy()
        configureDataSource()
    }
    
    // MARK: - Configure Hierarchy
    private func configureHierarchy() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: createLayout()
        )
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TextCell.self,
                                forCellWithReuseIdentifier: TextCell.reuseId)
        view.addSubview(collectionView)
    }
    
    // MARK: - Create Layout
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.2),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.2)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    // MARK: - Configure Data Source
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                
                guard
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: TextCell.reuseId,
                        for: indexPath
                    ) as? TextCell
                else { fatalError("Cannot create new cell") }
                
                cell.label.text = "\(itemIdentifier)"
                cell.contentView.backgroundColor = .systemBlue
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.label.textAlignment = .center
                
                return cell
            })
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<94))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
