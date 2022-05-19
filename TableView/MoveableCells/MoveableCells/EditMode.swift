//
//  EditMode.swift
//  MoveableCells
//
//  Created by Олег Федоров on 19.05.2022.
//

import Foundation
import UIKit

class EditMode: UIViewController {
    
    enum Section: Int {
        case visited = 0
        case bucketList
        
        func description() -> String {
            switch self {
            case .visited:
                return "Visited"
            case .bucketList:
                return "Bucket List"
            }
        }
        
        func secondaryDescrption() -> String {
            switch self {
            case .visited:
                return "Trips I've made!"
            case .bucketList:
                return "Need to do this before I go."
            }
        }
    }
    
    typealias SectionType = Section
    typealias ItemType = Place
    
    let reuseID = "reuse-id"
    
    class MoveableCellDataSource: UITableViewDiffableDataSource<SectionType, ItemType> {
        
        // MARK: header/footer titles
        override func tableView(_ tableView: UITableView,
                                titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.description()
        }
        
        override func tableView(_ tableView: UITableView,
                                titleForFooterInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.secondaryDescrption()
        }
        
        // MARK: reordering
        override func tableView(_ tableView: UITableView,
                                canMoveRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        override func tableView(_ tableView: UITableView,
                                moveRowAt sourceIndexPath: IndexPath,
                                to destinationIndexPath: IndexPath) {
            
            // get our source & destination (from & to)
            guard
                let sourceIdentifier = itemIdentifier(for: sourceIndexPath),
                sourceIndexPath != destinationIndexPath
            else { return }
            
            let destinationIdentifier = itemIdentifier(for: destinationIndexPath)
            
            // take snapshot before
            var snapshot = self.snapshot()
            
            // if moving within a section
            if let destinationIdentifier = destinationIdentifier {
                
                guard
                    let sourceIndex = snapshot.indexOfItem(sourceIdentifier),
                    let destinationIndex = snapshot.indexOfItem(destinationIdentifier)
                else { return }
                
                // delete it
                snapshot.deleteItems([sourceIdentifier])
                
                // figure out if before or after (and double check same section)
                let isAfter = destinationIndex > sourceIndex &&
                snapshot.sectionIdentifier(containingItem: sourceIdentifier) ==
                snapshot.sectionIdentifier(containingItem: destinationIdentifier)
                
                // insert back either before or after
                if isAfter {
                    snapshot.insertItems([sourceIdentifier], afterItem: destinationIdentifier)
                } else {
                    snapshot.insertItems([sourceIdentifier], beforeItem: destinationIdentifier)
                }
            }
            // move between sections
            else {
                // get the new destination section
                let destinationSectionIdentifier = snapshot.sectionIdentifiers[destinationIndexPath.section]
                // delete where it was
                snapshot.deleteItems([sourceIdentifier])
                // add to where it going
                snapshot.appendItems([sourceIdentifier], toSection: destinationSectionIdentifier)
            }
            
            apply(snapshot, animatingDifferences: false)
        }
        
        // MARK: editing support
        override func tableView(_ tableView: UITableView,
                                canEditRowAt indexPath: IndexPath) -> Bool {
            true
        }
        
        override func tableView(_ tableView: UITableView,
                                commit editingStyle: UITableViewCell.EditingStyle,
                                forRowAt indexPath: IndexPath) {
            // when deleting a row...
            if editingStyle == .delete {
                if let identifierToDelete = itemIdentifier(for: indexPath) {
                    var snapshot = self.snapshot()
                    snapshot.deleteItems([identifierToDelete])
                    apply(snapshot)
                }
            }
        }
    }
    
    var dataSource: MoveableCellDataSource!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureDataSource()
        configureNavigationItem()
    }
}

extension EditMode {
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        let formatter = NumberFormatter()
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true
        
        dataSource = MoveableCellDataSource(tableView: tableView) { tableView, indexPath, place in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseID) else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: self.reuseID)
            }
            
            cell.textLabel?.text = place.name
            
            return cell
        }
        
        let snapshot = initialSnapshot()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func initialSnapshot() -> NSDiffableDataSourceSnapshot<SectionType, ItemType> {
        let places = Place.getPlaces()
        let amount = places.count
        let bucketList = Array(places[0..<amount / 2])
        let visited = Array(places[amount / 2..<amount])
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        snapshot.appendSections([.visited])
        snapshot.appendItems(visited)
        snapshot.appendSections([.bucketList])
        snapshot.appendItems(bucketList)
        
        return snapshot
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Edit Mode"
        
        let editingItem = UIBarButtonItem(
            title: tableView.isEditing ? "Done" : "Edit",
            style: .plain,
            target: self,
            action: #selector(toggleEditing)
        )
        navigationItem.rightBarButtonItems = [editingItem]
    }
    
    @objc
    private func toggleEditing() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        configureNavigationItem()
    }
}
