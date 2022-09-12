//
//  DetailViewModel.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 16/08/22.
//  Coredata -> Service

import UIKit.UIApplication
import CoreData

final class DetailViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var favorites = [Favorite]()
    private var characterData: Character?
    private var stringID: String?
    private var isSelectedFavorite: Bool = false
    private var isRemoved: Bool = false
    
    init(characterData: Character?) {
        self.characterData = characterData
    }
    
    var getFillStarName: String {
        return "star.fill"
    }
    
    var getEmptyStarName: String {
        return "star"
    }
    
    var getIsSelectedFavorite: Bool {
        return isSelectedFavorite
    }
  
    func setStringID(intID: Int?) {
        guard let id = intID else {
            return
        }
        
        self.stringID = String(id)
    }
    
    func changeFavoritesCondition() {
        isSelectedFavorite = !isSelectedFavorite
    }
    
    //MARK:  - Core Data Methods (Create and Read)
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving favorites \(error)")
        }
    }
    
    func loadFavorites() {
        let request : NSFetchRequest<Favorite> = Favorite.fetchRequest()
        do {
            favorites = try context.fetch(request)
        } catch {
            print("Error for loading favorites \(error)")
        }
    }
    
    func getIsFavorite() -> Bool {
        isSelectedFavorite = favorites.compactMap { $0.id }.contains(stringID)
        return isSelectedFavorite
    }
    
    func didSelectFavorite() {
        if isSelectedFavorite {
            didSaveFavorite()
        } else {
            for favorite in favorites {
                if favorite.id == stringID {
                    didDeleteFavorite(with: favorite)
                }
            }
        }
    }
    
    //MARK: - Save and Delete Favorite Object
    private func didDeleteFavorite(with favorite: Favorite) {
        context.delete(favorite)
        saveContext()
    }
    
    private func didSaveFavorite() {
        let newFavorite = Favorite(context: self.context)
        newFavorite.id = stringID
        newFavorite.name = characterData?.name
        newFavorite.isFavorite = isSelectedFavorite
        newFavorite.gender = characterData?.gender
        newFavorite.status = characterData?.status
        newFavorite.species = characterData?.species
        newFavorite.origin = characterData?.origin.name
        newFavorite.image = characterData?.image
        favorites.append(newFavorite)
        saveContext()
    }
}
