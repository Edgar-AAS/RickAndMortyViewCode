    //
//  ViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 28/03/22.
//

import UIKit
    
final class GenericListViewController: UIViewController {
    private var collectionView: UICollectionView?
    private var viewModel: GenericListViewModel!
    private var characterResults = [Character]()
    
    init(viewModel: GenericListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadFavorites()
        
        navigationController?.navigationBar.backgroundColor = .black
        
        guard let indexPaths = collectionView?.indexPathsForSelectedItems else { return }
        collectionView?.reloadItems(at: indexPaths)
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayoutCollection()
        setupColletionView()
        
        title = viewModel.getTitleText()
        
        viewModel.delegate = self
        viewModel.fetchCategory(currentPage: viewModel.getCurrentPage)
    }
    
    private func setupLayoutCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.width/2)-2, height: (view.frame.width/2)-2)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    private func setupColletionView() {
        guard let collectionView = collectionView else { return }
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
    }
}

//MARK: - Updating ViewController
extension GenericListViewController: GenericListViewModelDelegate {
    func didUpadateController(_ genericListViewModel: GenericListViewModel, charactersResult: RickAndMortyData) {
        self.characterResults.append(contentsOf: charactersResult.results)
        viewModel.setCharacterResult(result: characterResults)
            
        UIView.performWithoutAnimation {
            collectionView?.reloadData()
        }
    }
    
    func didFailRequest(_ genericListViewModel: GenericListViewModel, error: Error) {
        print(error)
    }
}
    
//MARK: - UICollectionViewDataSource
extension GenericListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as? CharacterCollectionViewCell else { fatalError("Unable to dequeue CharacterCell") }
        
        cell.characterImage.dowloadImage(at: characterResults[indexPath.row].image)
        cell.nameLabel.text = characterResults[indexPath.row].name

        let favoritesArrayID = viewModel.getFavorite.compactMap { $0.id }
        let resultID = String(characterResults[indexPath.row].id)
        
        if favoritesArrayID.contains(resultID) {
            cell.characterImage.layer.borderColor = UIColor.orange.cgColor
        } else {
            cell.characterImage.layer.borderColor = UIColor.darkGray.cgColor
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension GenericListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.getNextPage(row: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController(character: characterResults[indexPath.row], viewModel: DetailViewModel(characterData: characterResults[indexPath.row]))
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
