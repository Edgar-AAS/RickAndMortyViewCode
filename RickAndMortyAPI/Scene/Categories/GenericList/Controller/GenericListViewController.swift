    //
    //  ViewController.swift
    //  RickAndMortyAPI
    //
    //  Created by Edgar Arlindo on 28/03/22.
    //
    import UIKit
    
    final class GenericListViewController: UIViewController, Coordinating {
        var coordinator: Coordinator?
        
        private var collectionView: UICollectionView?
        
        private var viewModel: GenericListViewModel
        
        init(viewModel: GenericListViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
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
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.frame = view.bounds
            view = collectionView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            viewModel.delegate = self
            title = viewModel.getTitleText()
            viewModel.fetchCategory(currentPage: viewModel.getCurrentPage)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            viewModel.loadFavorites()
            
            guard let indexPath = collectionView?.indexPathsForSelectedItems else { return }
            collectionView?.reloadItems(at: indexPath)
        }
    }
    
    //MARK: - Updating ViewController
    extension GenericListViewController: GenericListViewModelDelegate {
        func didUpadateController(_ genericListViewModel: GenericListViewModel, charactersResult: RickAndMortyData) {
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
            return viewModel.getCount
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as? CharacterCollectionViewCell else { fatalError("Unable to dequeue CharacterCell") }
            
            cell.setupGenericCell(with: viewModel.loadCurrentCharacter(indexPath: indexPath))
            
            if viewModel.validateFavorite(indexPath: indexPath) {
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
            coordinator?.eventOcurred(with: .pushCharacterDetail(viewModel.loadCurrentCharacter(indexPath: indexPath)))
        }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    extension GenericListViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (view.frame.width/2)-2, height: (view.frame.width/2)-2)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return viewModel.getMinimumLineSpacingForSection()
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return viewModel.getMinimumInteritemSpacingForSection()
        }
    }
