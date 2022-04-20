//
//  ViewController.swift
//  Pagination
//
//  Created by Олег Федоров on 26.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let apiCaller = APICaller()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    private var activityIndicator: UIActivityIndicatorView?
    
    private var posts = [Post]()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Posts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 100
        
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    // MARK: - Private Methods
    private func fetchData() {
        activityIndicator = showActivityIndicator(in: view)
        
        apiCaller.fetchData(pagination: false) { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts.append(contentsOf: posts)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.activityIndicator?.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: view.frame.size.width,
                                              height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        
        return footerView
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray2
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        return activityIndicator
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath
        )
        
        cell.textLabel?.text = posts[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
}

// MARK: - UITableViewDelegate, UIScrollViewDelegate
extension ViewController: UITableViewDelegate, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            // fetch more data
            guard !apiCaller.isPaginating else {
                // we are already fetching more data
                return
            }
            
            self.tableView.tableFooterView = createSpinnerFooter()
            
            apiCaller.fetchData(pagination: true) { [weak self] result in
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                }

                switch result {
                case .success(let morePosts):
                    self?.posts.append(contentsOf: morePosts)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
