//
//  EndPointProtocol.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 31/10/22.
//

import Foundation

protocol EndPoint {
    var baseURL: String { get set }
    var endPoint: String { get set}
    func buildURLString(currentPage: Int) -> String
}
