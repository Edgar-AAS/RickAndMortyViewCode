//
//  DetailScreenViewModel.swift
//  RickAndMortyAPI
//
//  Created by Leonardo Almeida on 03/09/22.
//

import UIKit.UIImage

final class DetailScreenViewModel {
    private enum CharacterStatusDescription: String {
        case status = "Status: "
        case specie = "Species: "
        case gender = "Gender: "
        case origin = "Origin: "
    }
    
    private var data: Result
    
    init(data: Result) {
        self.data = data
    }
        
    var getImageURL: String {
        data.image
    }
    
    var getName: String {
        return data.name
    }
    
    var getStatus: String {
        return CharacterStatusDescription.status.rawValue + data.status
    }
    
    var getSpecies: String {
        return CharacterStatusDescription.specie.rawValue + data.species
    }
    
    var getGender: String {
        return CharacterStatusDescription.gender.rawValue + data.gender
    }
    
    var getOrigin: String {
        return CharacterStatusDescription.origin.rawValue + data.origin.name
    }
    
}
