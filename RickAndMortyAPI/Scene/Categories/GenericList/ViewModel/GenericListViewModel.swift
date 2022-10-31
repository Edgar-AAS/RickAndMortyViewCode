//
//  SpeciesViewModel.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 11/08/22.
//

import UIKit.UIImageView
import CoreData

protocol GenericListViewModelDelegate: AnyObject {
    func didUpadateController(_ genericListViewModel: GenericListViewModel, charactersResult: RickAndMortyData)
    func didFailRequest(_ : GenericListViewModel, error: Error)
}

final class GenericListViewModel {
    private let endPointProtocol: EndPoint
    private var currentPage = 1
    private let totalPage = 42
    private var favoritesResult = [Favorite]()
    private var charaterResults = [Character]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(endPoint: EndPoint) {
        self.endPointProtocol = endPoint
    }
    
    func loadCurrentCharacter(indexPath: IndexPath) -> Character {
        return charaterResults[indexPath.row]
    }
    
    func getMinimumLineSpacingForSection() -> CGFloat {
        return 10
    }
    
    func getMinimumInteritemSpacingForSection() -> CGFloat {
        return 1
    }
    
    var getCharacterResult: [Character] {
        return charaterResults
    }
    
    var getCount: Int {
        return charaterResults.count
    }
    
    func getImageString(indexPath: IndexPath) -> String {
        return charaterResults[indexPath.row].image
    }
    
    var getCurrentPage: Int {
        return currentPage
    }
    
    var getFavorite: [Favorite] {
        return favoritesResult
    }
    
    func getTitleText() -> String {
        return endPointProtocol.endPoint.capitalized
    }
    
    func validateFavorite(indexPath: IndexPath) -> Bool {
        let currentID = String(charaterResults[indexPath.row].id)
        let IdArray = favoritesResult.compactMap({ $0.id })
        return IdArray.contains(currentID)
    }
    
    weak var delegate: GenericListViewModelDelegate?
    
    func fetchCategory(currentPage: Int) {
        WebService.getAllRequest(of: RickAndMortyData.self, from: endPointProtocol.buildURLString(currentPage: currentPage)) { (result) in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.delegate?.didUpadateController(self, charactersResult: result)
                    self.charaterResults.append(contentsOf: result.results)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Core data read
    func loadFavorites() {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do {
            favoritesResult = try context.fetch(request)
        } catch {
            print("Error loading favorites \(error)")
        }
    }
    
    //MARK: Pagination
    func getNextPage(row: Int) {
        if currentPage < totalPage && row == charaterResults.count - 1 {
            currentPage += 1
            self.fetchCategory(currentPage: currentPage)
        }
    }
}
