//
//  SpeciesViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 12/08/22.
//

import UIKit

final class SpeciesTableViewController: UITableViewController {
    
    let viewModel = SpecieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.getTitle

        tableView.rowHeight = viewModel.tablewViewRowHeight
        tableView.register(SpeciesTableViewCell.self, forCellReuseIdentifier: SpeciesTableViewCell.specieCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .black
    }
}

extension SpeciesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SpeciesTableViewCell.specieCell, for: indexPath) as? SpeciesTableViewCell else {
            fatalError("Unable to dequeue GenderCell")
        }
        
        cell.setupSpecieCell(specie: viewModel.getSpecie(indexPath: indexPath))
        return cell
    }
}

extension SpeciesTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = ListOfCategories(rawValue: viewModel.getSpecie(indexPath: indexPath)) else { return }
        let viewModel = GenericListViewModel(category: category, isSpecies: true)
        let viewController = GenericListViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
