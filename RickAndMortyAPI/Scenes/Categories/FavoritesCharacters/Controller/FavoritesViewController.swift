//
//  FavoritesViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 30/05/22.
//

import UIKit

final class FavoritesViewController: UIViewController {     
    
    private var collectionView: UICollectionView?
    private var viewModel = FavoritesViewModel()
    
    override func loadView() {
        super.loadView()
        
        setupLayoutCollection()
        setupColletionView()
    }
    
    private func setupLayoutCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    private func setupColletionView() {
        guard let collectionView = collectionView else { return }
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = viewModel.getTitle
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchFavoritesResult()
        viewModel.reverseFavoriteResults()
        
        
        collectionView?.reloadData()
        
    }
}

//MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
            fatalError("Unable to dequeue CharacterCell")
        }
        
        guard let favoriteMapped = viewModel.mappingFavorite(indexPath: indexPath) else { return UICollectionViewCell() }
        
        cell.setupGenericCell(with: favoriteMapped)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let favoriteMapped = viewModel.mappingFavorite(indexPath: indexPath) else { return }
        
        let detailViewController = DetailViewController(character: favoriteMapped, viewModel: DetailViewModel(characterData: favoriteMapped))
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2)-2, height: (view.frame.width/2)-2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.getMinimumLineSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.getMinimumInteritemSpacingForSection
    }
}
