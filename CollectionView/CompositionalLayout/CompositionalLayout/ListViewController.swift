//
//  ViewController.swift
//  CompositionalLayout
//
//  Created by Олег Федоров on 30.03.2022.
//

import UIKit

// MARK: - ListCell
class ListCell: UICollectionViewCell {
    
    static let reuseId = "ListCellId"
    
    let label = UILabel()
    let accessoryImageView = UIImageView()
    let separatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Cell
extension ListCell {
    private func configure() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        contentView.addSubview(label)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .systemGray
        contentView.addSubview(separatorView)
        
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .lightGray.withAlphaComponent(0.3)
        
        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(accessoryImageView)
        
        let rtl = effectiveUserInterfaceLayoutDirection == .rightToLeft
        let chevronImageName = rtl ? "chevron.left" : "chevron.right"
        let chevronImage = UIImage(systemName: chevronImageName)
        accessoryImageView.image = chevronImage
        accessoryImageView.tintColor = .systemGray.withAlphaComponent(0.7)
        
        let inset: CGFloat = 10
        NSLayoutConstraint.activate([
            // label
            label.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: inset
            ),
            label.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: inset
            ),
            label.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -inset
            ),
            label.trailingAnchor.constraint(
                equalTo: accessoryImageView.leadingAnchor, constant: -inset
            ),
            
            // accessoryImageView
            accessoryImageView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            accessoryImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -inset
            ),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 13),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // separatorView
            separatorView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: inset
            ),
            separatorView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -inset
            ),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}

// MARK: - ListViewController
class ListViewController: UIViewController {
    
    private enum Section {
        case main
    }

    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    private var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List"
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
        collectionView.register(ListCell.self,
                                forCellWithReuseIdentifier: ListCell.reuseId)
        view.addSubview(collectionView)
    }
    
    // MARK: - Create Layout
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
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
        
        // Create Diffable Data Source and connect to Collection View
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                
                // A constructor that passes the collection view as input,
                // and returns a cell as output
                
                guard
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: ListCell.reuseId,
                        for: indexPath
                    ) as? ListCell
                else { fatalError("Cannot create new cell")}
                
                cell.label.text = "\(itemIdentifier)"
                
                return cell
            })
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<94))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

