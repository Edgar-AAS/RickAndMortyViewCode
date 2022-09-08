//
//  CategorieTableViewController.swift
//  RickAndMortyAPI
//
//  Created by Leonardo Almeida on 01/08/22.
//

import UIKit

class ListTableViewController: UITableViewController {
    var categories = K.categoriesArray
    let species = K.speciesArray
    
//    lazy var customView: CategorieScreen? = {
//       return view as? CategorieScreen
//    }()
    
    private let cellIdentifier = "cellId"
    
//    override func loadView() {
//        super.loadView()
//        view = CategorieScreen()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

//MARK: - UITableViewDataSource
extension ListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if categories[indexPath.row] == "Species" {
            categories = species
            tableView.reloadData()
        }
    }
}
