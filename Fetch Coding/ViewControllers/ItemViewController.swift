//
//  ItemViewController.swift
//  Fetch Coding
//
//  Created by Kalyan Chakravarthy Narne on 5/23/23.
//

import UIKit

class ItemViewController: UIViewController {
    
    var items: [Item] = []
    var allItems: [Item] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        configureTableView()
        getItems()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationBar() {
        title = "Desserts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Set up the search controller
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifiers.itemTableViewCell)
    }
    
    private func getItems() {
        ItemsViewModel().getItems(for: .dessert) { [weak self] items in
            DispatchQueue.main.async {
                self?.items = items
                self?.allItems = items
                self?.tableView.reloadData()
            }
        }
    }
}

extension ItemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifiers.itemTableViewCell, for: indexPath) as? ItemTableViewCell else {
            return UITableViewCell()
        }
        cell.setUp(with: items[indexPath.row])
        return cell
    }
}

extension ItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = IngredientViewController(with: items[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ItemViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterItems(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        filterItems(with: "")
        searchBar.resignFirstResponder()
    }
    
    private func filterItems(with searchText: String) {
        if searchText.isEmpty {
            items = allItems
        } else {
            items = allItems.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
}
