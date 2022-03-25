//
//  SelectorViewController.swift
//  UISheetPresentationController
//
//  Created by Олег Федоров on 25.03.2022.
//

import UIKit

class SelectorViewController: UIViewController {
    
    let games = [
        "Counter-Strike",
        "Dota2",
        "WoW"
    ]
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topAnchorConstraint: NSLayoutConstraint!
    
    var topAnchorValue: CGFloat
    
    init(topAnchorValue: CGFloat) {
        self.topAnchorValue = topAnchorValue
        
        super.init(nibName: "SelectorViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension SelectorViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = games[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        games.count
    }
}
