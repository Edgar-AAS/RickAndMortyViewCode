//
//  CharacterCell.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 27/07/22.
//

import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: CharacterCollectionViewCell.self)
    
    lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    var viewModel: ViewModel?
            
    struct ViewModel {
        let name: String
        let image: UIImage
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .black
        contentView.addSubview(characterImage)
        contentView.addSubview(nameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        characterImage.frame = CGRect(x: 5,
                               y: 0,
                               width: contentView.frame.width-10,
                               height: contentView.frame.size.height-15)
        
        nameLabel.frame = CGRect(x: 5,
                               y: contentView.frame.size.height-15,
                               width: contentView.frame.width-10,
                               height: 15)
    }
}
