//
//  SpeciesViewModel.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 11/08/22.
//

import UIKit.UIImageView
import CoreData

protocol GenericListViewModelDelegate: AnyObject {
    func didUpadateController(_ genericListViewModel: GenericListViewModel, charactersResult: [Result])
}

final class GenericListViewModel {
    private let category: ListOfCategories
    private var isSpecies: Bool
    private var isGender: Bool
    private var currentPage = 1
    private let totalPage = 42
    private var favoritesResult = [Favorite]()
    private var charaterResults = [Result]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    init(category: ListOfCategories, isSpecies: Bool = false, isGender: Bool = false) {
        self.category = category
        self.isSpecies = isSpecies
        self.isGender = isGender
    }
    
    weak var delegate: GenericListViewModelDelegate?
    
    var getCurrentPage: Int {
        return currentPage
    }
    
    var getFavorite: [Favorite] {
        return favoritesResult
    }
    
    func getTitleText() -> String {
        return category.rawValue
    }
    
    func setCharacterResult(result: [Result]) {
        self.charaterResults = result
    }
    
    func fetchCategory(currentPage: Int) {
        let endPoint: String
            
        switch category {
        case .alive:
            endPoint = EndPoints.alive
        case .dead:
            endPoint = EndPoints.dead
        case .unknown:
            if isSpecies {
                endPoint = EndPoints.speciesUnknown
            } else if isGender {
                endPoint = EndPoints.genderUnknown
            } else {
                endPoint = EndPoints.statusUnknown
            }
        case .human:
            endPoint = EndPoints.human
        case .humanoid:
            endPoint = EndPoints.humanoid
        case .alien:
            endPoint = EndPoints.alien
        case .poopybutthole:
            endPoint = EndPoints.poopybutthole
        case .mythologycalCreature:
            endPoint = EndPoints.mythologicalCreature
        case .male:
            endPoint = EndPoints.male
        case .female:
            endPoint = EndPoints.female
        case .genderless:
            endPoint = EndPoints.genderless
        default:
            endPoint = ""
            return
        }
                
        RickAndMortyManager().performRequest(endPoint: endPoint, currentPage: currentPage) { (data) in
            guard let results = data?.results else { return }
            self.delegate?.didUpadateController(self, charactersResult: results)
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
