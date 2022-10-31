//
//  SpecsViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 29/03/22.
//

import UIKit

final class DetailViewController: UIViewController, Coordinating  {
    var coordinator: Coordinator?
    
    private lazy var customView: DetailScreen? = {
       return view as? DetailScreen
    }()
    
    private let character: Character?
    private let characterDataManager: CharacterDataManager
    
    init(character: Character, manager: CharacterDataManager) {
        self.characterDataManager = manager
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = DetailScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: characterDataManager.getFillStarName), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        characterDataManager.setStringID(intID: character?.id)
        characterDataManager.loadFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem?.image = configureImageStar()
        
        if characterDataManager.getIsFavorite() {
            customView?.characterImage.layer.borderColor = UIColor.orange.cgColor
        }
    }
    
   private func configureImageStar() -> UIImage? {
        if characterDataManager.getIsFavorite() {
            return UIImage(systemName: characterDataManager.getFillStarName)
        } else {
            return UIImage(systemName: characterDataManager.getEmptyStarName)
        }
    }
    
    private func configureBorderColor() {
        if characterDataManager.getIsSelectedFavorite {
            customView?.characterImage.layer.borderColor = UIColor.orange.cgColor
        } else {
            customView?.characterImage.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    @objc func favoriteButtonTapped(sender: UIBarButtonItem) {
        characterDataManager.changeFavoritesCondition()
        sender.image = characterDataManager.getIsSelectedFavorite ? UIImage(systemName: characterDataManager.getFillStarName) : UIImage(systemName: characterDataManager.getEmptyStarName)
        configureBorderColor()
        characterDataManager.didSelectFavorite()
    }
    
    private func setupView() {
        guard let character = character else { return }
        customView?.setupCharacterData(character: character)
    }
}
