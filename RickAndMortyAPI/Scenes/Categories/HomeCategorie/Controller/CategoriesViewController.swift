//
//  CategorieTableViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 01/08/22.
//

import UIKit

final class CategoriesViewController: UITableViewController, Coordinating {
    var coordinator: Coordinator?
    
    private let viewModel = CategorieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.getTitle
        
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.rowHeight = viewModel.tableViewRowHeight
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.categorieCell)
        view.backgroundColor = .black
        configureNavigate()
    }
    
    func configureNavigate() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
//MARK: - UITableViewDataSource
extension CategoriesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.categorieCell, for: indexPath) as? CategoriesTableViewCell else {
            fatalError("Unable to dequeue GenderCell")}
        cell.setupCategorieCell(categorie: viewModel.getCategorie(indexPath: indexPath))
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CategoriesViewController {    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = CategoryType(rawValue: viewModel.getCategorie(indexPath: indexPath).lowercased()) else {
            return
        }
        coordinator?.eventOcurred(with: .statusList(category))
    }
}
