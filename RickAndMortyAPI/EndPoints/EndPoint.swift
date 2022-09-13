//
//  EndPoints.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 17/08/22.
//

import Foundation

struct EndPoint {
    static let alive = "&status=alive"
    static let dead = "&status=dead"
    static let statusUnknown = "&status=unknown"
    static let male = "&gender=male"
    static let female = "&gender=female"
    static let genderless = "&gender=genderless"
    static let genderUnknown = "&gender=unknown"
    static let human = "&species=human"
    static let humanoid = "&species=humanoid"
    static let alien = "&species=alien"
    static let speciesUnknown = "&species=unknown"
    static let poopybutthole = "&species=poopybutthole"
    static let mythologicalCreature = "&species=Mythological%20Creature"
    
    static func buildUrl(currentPage: Int, endPoint: String) -> String {
        let urlBase = "https://rickandmortyapi.com/api/character/"
        let urlString = urlBase + "?page=\(currentPage)" + endPoint
        return urlString
    }
}
