//
//  ViewController.swift
//  DiffableDataSource
//
//  Created by Олег Федоров on 31.03.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private enum Section {
        case first
    }
    
    private struct Fruit: Hashable {
        let title: String
        
        let id = UUID()
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    private var dataSource: UITableViewDiffableDataSource<Section, Fruit>!
    private var fruits = [Fruit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Fruits"
        setupNavBar()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        configureDataSource()
    }
    
    // MARK: - Setup NavBar
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .done,
            target: self,
            action: #selector(didTapAdd)
        )
    }
    
    // MARK: - Configure Data Source
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, model in
                
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "cell",
                    for: indexPath
                )
                
                cell.textLabel?.text = model.title
                
                return cell
            }
        )
    }
    
    // MARK: - Actions
    @objc func didTapAdd() {
        let actionSheet = UIAlertController(
            title: "Select Fruit", message: nil,
            preferredStyle: .actionSheet
        )
        
        for i in 0...100 {
            actionSheet.addAction(UIAlertAction(
                title: "Fruit \(i + 1)",
                style: .default,
                handler: { [weak self] _  in
                    let fruit = Fruit(title: "Fruit \(i + 1)")
                    self?.fruits.append(fruit)
                    self?.updateDataSource()
                })
            )
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    private func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Fruit>()
        snapshot.appendSections([.first])
        snapshot.appendItems(fruits)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let fruit = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        print("DEBUG: \(fruit)")
    }
}

