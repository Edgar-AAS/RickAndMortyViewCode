//
//  ViewModelCharacterCell.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 12/09/22.
//

import Foundation

import UIKit.UIImageView

class CustomCellViewModel {
    private var character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    func getCharacterImageString() -> String {
        return character.image
    }
    
    func getCharacterName() -> String {
        return character.name
    }
}
