//
//  FavoritesViewModel.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 17/08/22.
//

import UIKit.UIApplication
import CoreData

final class FavoritesViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var favoriteResult = [Favorite?]()
    
    func reverseFavoriteResults() {
        favoriteResult.reverse()
    }
    
    var getFavoriteResult: [Favorite?] {
        return favoriteResult
    }
    
    func fetchFavoritesResult() {
        let request : NSFetchRequest<Favorite> = Favorite.fetchRequest()
        do {
            self.favoriteResult = try self.context.fetch(request)
        } catch {
            fatalError("error for load favorites: \(error.localizedDescription)")
        }
    }
    
    func mappingFavorite(favorite: Favorite) -> Result? {
        guard let id = favorite.id,
              let name = favorite.name,
              let status = favorite.status,
              let species = favorite.species,
              let gender = favorite.gender,
              let origin = favorite.origin,
              let image = favorite.image else {
            return nil
        }
        
        return Result(
            id: Int(id) ?? 0,
            name: name,
            status: status,
            species: species,
            gender: gender,
            origin: .init(name: origin, url: ""),
            image: image
        )
    }
}
