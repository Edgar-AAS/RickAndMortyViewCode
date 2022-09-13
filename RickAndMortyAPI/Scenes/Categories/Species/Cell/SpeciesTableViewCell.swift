//
//  SpeciesTableViewCell.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 07/09/22.
//

import UIKit

final class SpeciesTableViewCell: UITableViewCell {
    static let specieCell = String(describing: SpeciesTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupSpecieCell(specie: String) {
       backgroundColor = .black
       textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
       textLabel?.textColor = .white
       textLabel?.text = specie
    }
}
