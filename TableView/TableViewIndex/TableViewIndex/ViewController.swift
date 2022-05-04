//
//  ViewController.swift
//  TableViewIndex
//
//  Created by Олег Федоров on 04.05.2022.
//

import UIKit

struct Group {
    let title: String
    let countries: [String]
}

class ViewController: UIViewController {

    private let countries: [String: [String]] = [
        "A": ["Australia", "Albania"],
        "B": ["Belarus", "Belgium", "Brazil"],
        "C": ["Canada", "Colombia"],
        "D": ["Denmark"],
        "F": ["Finland", "France"],
        "G": ["Germany", "Greece", "Georgia"],
        "L": ["Liechtenstein", "Luxembourg"],
        "M": ["Malaysia", "Mexico"],
        "P": ["Peru", "Poland"],
        "R": ["Romania"],
        "S": ["Serbia", "Singapore", "South Korea"],
        "T": ["Turkey", "Togo"]
    ]
    
    private let alphabet = "abcdefghijklmnopqrstuvwxyz"
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.sectionIndexColor = .label
        return table
    }()
    
    private var models = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpData()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.frame.size.width,
            height: view.frame.size.height - view.safeAreaInsets.top
        )
    }
    
    func setUpData() {
        for (key, value) in countries {
            models.append(Group(title: key, countries: value))
        }
        models = models.sorted(by: { $0.title < $1.title })
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.section].countries[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        models[section].title
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        Array(alphabet.uppercased().compactMap { "\($0)" })
    }
    
    func tableView(_ tableView: UITableView,
                   sectionForSectionIndexTitle title: String,
                   at index: Int) -> Int {
        guard let targerIndex = models.firstIndex(where: { $0.title == title }) else {
            return 0
        }
        
        return targerIndex
    }
}
