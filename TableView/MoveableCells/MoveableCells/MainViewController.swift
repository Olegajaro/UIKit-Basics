//
//  ViewController.swift
//  MoveableCells
//
//  Created by Олег Федоров on 19.05.2022.
//

import UIKit

private let cellID = "Cell"

class MainViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let numbers = ["Edit Mode", "Long Press"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setup()
    }
}

// MARK: - Setup Table View
extension MainViewController {
    private func setupNavBar() {
        title = "Moveable Cells"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setup() {
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        numbers.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellID,
            for: indexPath
        )
        
        var content = cell.defaultContentConfiguration()
        content.text = numbers[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(EditMode(), animated: true)
        case 1:
            navigationController?.pushViewController(LongPress(), animated: true)
        default:
            break
        }
    }
}

