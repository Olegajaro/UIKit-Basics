//
//  TwoColumnGridViewController.swift
//  CompositionalLayout
//
//  Created by Олег Федоров on 31.03.2022.
//

import UIKit

class TwoColumnGridViewController: UIViewController {
    
    private enum Section {
        case main
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    private var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Two-Column Grid"
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
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        /*
         Here we are saying make me two columns. Horizontal count: 2.
         Even though the itemSize say - make me 1:1, the group layout
         overrides that and makes it stretch to something longer.
         So group overrides item.
         */
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )
        let spacing: CGFloat = 10
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        
        // Another wat to add spacing. This is done for the section.
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing,
                                                        bottom: 0, trailing: spacing)
        
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


