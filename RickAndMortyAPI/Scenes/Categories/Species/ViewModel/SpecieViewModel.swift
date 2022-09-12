//
//  SpecieViewModel.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 07/09/22.
//

import Foundation
import CoreGraphics

final class SpecieViewModel {
    private let speciesArray = K.speciesArray
    
    func getSpecie(indexPath: IndexPath) -> String {
        return speciesArray[indexPath.row]
    }
    
    var getCount: Int {
        return speciesArray.count
    }
    
    var tablewViewRowHeight: CGFloat {
        return 100
    }
    
    var getTitle: String {
        return "Species"
    }
}
