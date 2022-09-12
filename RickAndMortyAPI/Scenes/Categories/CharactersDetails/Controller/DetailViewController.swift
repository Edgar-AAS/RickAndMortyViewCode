//
//  SpecsViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 29/03/22.
//

import UIKit

final class DetailViewController: UIViewController  {
    
    private lazy var customView: DetailScreen? = {
       return view as? DetailScreen
    }()
    
    private let character: Character?
    private let viewModel: DetailViewModel
    
    init(character: Character, viewModel: DetailViewModel) {
        self.viewModel = viewModel
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: viewModel.getFillStarName), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        viewModel.setStringID(intID: character?.id)
        viewModel.loadFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem?.image = configureImageStar()
        
        if viewModel.getIsFavorite() {
            customView?.characterImage.layer.borderColor = UIColor.orange.cgColor
        }
    }
    
   private func configureImageStar() -> UIImage? {
        if viewModel.getIsFavorite() {
            return UIImage(systemName: viewModel.getFillStarName)
        } else {
            return UIImage(systemName: viewModel.getEmptyStarName)
        }
    }
    
    private func configureBorderColor() {
        if viewModel.getIsSelectedFavorite {
            customView?.characterImage.layer.borderColor = UIColor.orange.cgColor
        } else {
            customView?.characterImage.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    @objc func favoriteButtonTapped(sender: UIBarButtonItem) {
        viewModel.changeFavoritesCondition()
        sender.image = viewModel.getIsSelectedFavorite ? UIImage(systemName: viewModel.getFillStarName) : UIImage(systemName: viewModel.getEmptyStarName)
        configureBorderColor()
        viewModel.didSelectFavorite()
    }
    
    private func setupView() {
        guard let character = character else { return }
        customView?.setupCharacterData(character: character)
    }
}
