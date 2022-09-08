//
//  CategorieTableViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 01/08/22.
//

import UIKit

final class CategoriesViewController: UITableViewController {
    private var categoriesArray = K.categoriesArray
    private let reusableIdentifier = String(describing: UITableViewCell.self)

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Categories"
        
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.rowHeight = 100
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reusableIdentifier)
    }
}

//MARK: - UITableViewDataSource
extension CategoriesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath)
        cell.backgroundColor = .black
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.textColor = .white
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = categoriesArray[indexPath.row]
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CategoriesViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = ListOfCategories(rawValue: categoriesArray[indexPath.row]) else { return }
        
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
            break
        }
    }
}
