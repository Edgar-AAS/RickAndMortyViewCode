//
//  CategorieViewModel.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 11/09/22.
//

import Foundation

class CategorieViewModel {
    private let categorieArray = K.categoriesArray
    
    func getCategorie(indexPath: IndexPath) -> String {
        return categorieArray[indexPath.row]
    }
    
    var getCount: Int {
        return categorieArray.count
    }
}
