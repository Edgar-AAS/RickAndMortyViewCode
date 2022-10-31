//
//  SpeciesTableViewCell.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 07/09/22.
//

import UIKit

final class SpeciesTableViewCell: UITableViewCell {
    static let specieCell = String(describing: SpeciesTableViewCell.self)
    
    func setupSpecieCell(specie: String) {
       backgroundColor = .black
       textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
       textLabel?.textColor = .white
       textLabel?.text = specie
    }
}
