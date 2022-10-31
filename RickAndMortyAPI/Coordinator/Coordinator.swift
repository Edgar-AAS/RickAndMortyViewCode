//
//  Coordinator.swift
//  RickAndMortyAPI
//
//  Created by Leonardo Almeida on 27/10/22.
//

import UIKit

enum Event {
    case charactersButtonTapped
    case statusList(CategoryType)
    case specieType(SpecieType)
    case genderType(GenderType)
    case pushCharacterDetail(Character)
    case pushFavoriteDetail(Character)
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func eventOcurred(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
