//
//  GenderTableViewCell.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 07/09/22.
//

import UIKit

final class GenderTableViewCell: UITableViewCell {
    static let genderCell = String(describing: GenderTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupGenderCell(gender: String) {
        textLabel?.text = gender
        backgroundColor = .black
        textLabel?.textColor = .white
        textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        accessoryType = .disclosureIndicator
    }
    
}
