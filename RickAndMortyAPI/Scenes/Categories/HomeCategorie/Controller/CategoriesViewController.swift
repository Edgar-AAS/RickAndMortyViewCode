//
//  CategorieTableViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 01/08/22.
//

import UIKit

final class CategoriesViewController: UITableViewController {
    
    private let viewModel = CategorieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.getTitle
        
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.rowHeight = viewModel.tableViewRowHeight
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.categorieCell)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .white

        view.backgroundColor = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.barTintColor = .black
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
        guard let category = ListOfCategories(rawValue: viewModel.getCategorie(indexPath: indexPath)) else { return }
        
        let viewController = GenericListViewController(viewModel: GenericListViewModel(category: category))
        
        switch category {
        case .alive, .dead, .unknown:
            navigationController?.pushViewController(viewController, animated: true)
        case .species:
            navigationController?.pushViewController(SpeciesTableViewController(style: .grouped), animated: true)
        case .gender:
            navigationController?.pushViewController(GenderTableViewController(style: .grouped), animated: true)
        case .favorites:
            navigationController?.pushViewController(FavoritesViewController(), animated: true)
        default:
            return
        }
    }
}
