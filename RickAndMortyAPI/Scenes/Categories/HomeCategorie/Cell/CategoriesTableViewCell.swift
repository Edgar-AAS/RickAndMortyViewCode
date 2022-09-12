//
//  CategoriesTableViewCell.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 11/09/22.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    static let categorieCell = String(describing: CategoriesTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCategorieCell(categorie: String) {
       backgroundColor = .black
       textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
       textLabel?.textColor = .white
       textLabel?.text = categorie
       accessoryType = .disclosureIndicator
    }
}
