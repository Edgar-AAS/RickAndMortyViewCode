//
//  GenderViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 11/08/22.
//

import UIKit

final class GenderTableViewController: UITableViewController {
    let viewModel = GenderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Gender"
        
        tableView.rowHeight = 100
        tableView.register(GenderTableViewCell.self, forCellReuseIdentifier: GenderTableViewCell.genderCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .black
    }
}

//MARK: - UITableViewDataSource
extension GenderTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.genderCell, for: indexPath) as? GenderTableViewCell else {
            fatalError("Unable to dequeue GenderCell")
        }
        
        cell.setupGenderCell(gender: viewModel.getGender(indexPath: indexPath))
        return cell
    }
}

//MARK: - UITableViewDelegate
extension GenderTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = ListOfCategories(rawValue: viewModel.getGender(indexPath: indexPath)) else { return }
        let viewModel = GenericListViewModel(category: category, isGender: true)
        let viewController = GenericListViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
