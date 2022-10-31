//
//  GenderViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 11/08/22.
//

import UIKit

final class GenderTableViewController: UITableViewController, Coordinating {
    var coordinator: Coordinator?
    
    let viewModel: GenderViewModel
    
    init(viewModel: GenderViewModel) {
        self.viewModel = viewModel
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.getTitle
        
        tableView.rowHeight = viewModel.tableViewRowHeight
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
        guard let genderType = GenderType(rawValue: viewModel.getGender(indexPath: indexPath).lowercased()) else {
            return
        }
        coordinator?.eventOcurred(with: .genderType(genderType))
    }
}
