//
//  FavoritesViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 30/05/22.
//

import UIKit

final class FavoritesViewController: UIViewController {     
    private var collectionView: UICollectionView?
    private var indexPath: IndexPath?
    private var viewModel = FavoritesViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        viewModel.fetchFavoritesResult()
        viewModel.reverseFavoriteResults()
        
        UIView.performWithoutAnimation {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = "Favorites"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.width/2)-2, height: (view.frame.width/2)-2)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
    }
}

//MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getFavoriteResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
            fatalError("Unable to dequeue CharacterCell")
        }
        
        guard let imageURL = viewModel.getFavoriteResult[indexPath.row]?.image else { return UICollectionViewCell() }
        cell.characterImage.dowloadImage(at: imageURL)
        cell.nameLabel.text = viewModel.getFavoriteResult[indexPath.row]?.name
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexPath = indexPath
        
        guard let favorite = viewModel.getFavoriteResult[indexPath.row] else {
            return
        }
        
        guard let result = viewModel.mappingFavorite(favorite: favorite) else {
            return
        }
        
        let detailViewController = DetailViewController(character: result, viewModel: DetailViewModel(characterData: result))
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
