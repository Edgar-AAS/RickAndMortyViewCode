//
//  SpeciesViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 12/08/22.
//

import UIKit

final class SpeciesTableViewController: UITableViewController, Coordinating {
    var coordinator: Coordinator?
    
    let viewModel: SpecieViewModel
    
    init(viewModel: SpecieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.getTitle
        tableView.rowHeight = viewModel.tablewViewRowHeight
        tableView.register(SpeciesTableViewCell.self, forCellReuseIdentifier: SpeciesTableViewCell.specieCell)
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
        let specieLowerCased = viewModel.getSpecie(indexPath: indexPath).lowercased()
        guard let specieType = SpecieType(rawValue: specieLowerCased) else {
            return
        }
        coordinator?.eventOcurred(with: .specieType(specieType))
    }
}
