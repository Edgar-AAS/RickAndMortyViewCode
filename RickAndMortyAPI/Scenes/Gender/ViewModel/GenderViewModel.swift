//
//  File.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 07/09/22.
//

import Foundation
import CoreGraphics

final class GenderViewModel {
    private let gendersArray = K.gendersArray
    
    func getGender(indexPath: IndexPath) -> String {
        return gendersArray[indexPath.row]
    }
    
    var getCount: Int {
        return gendersArray.count
    }
    
    var tableViewRowHeight: CGFloat {
        return 100
    }
    
    var getTitle: String {
        return "Gender"
    }
}
