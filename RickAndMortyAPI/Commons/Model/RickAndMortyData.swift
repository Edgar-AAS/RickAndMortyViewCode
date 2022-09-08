//
//  RickAndMortyData.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 28/03/22.
//

import Foundation

struct RickAndMortyData: Codable {
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let image: String
}

struct Origin: Codable {
    let name: String
    let url: String
}   
