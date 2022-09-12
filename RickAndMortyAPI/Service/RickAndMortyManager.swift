//
//  RickAndMortyManager.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 28/03/22.
//

import Foundation

enum NetWorkingError: Swift.Error {
    case requestError(name: String)
}

typealias dataTaskResult = (_ result: [Result]?, _ failure: Error?) -> Void

class Service {
    private var urlRickAndMortyAPI = "https://rickandmortyapi.com/api/character/?page="
    
    func performRequest(endPoint: String, currentPage: Int, completion: @escaping dataTaskResult) {
        if let url = URL(string: urlRickAndMortyAPI + "\(currentPage)" + endPoint) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    do {
                        let decodedData = try JSONDecoder().decode(RickAndMortyData.self, from: safeData)
                        DispatchQueue.main.async {
                            completion(decodedData.results, nil)
                        }
                    } catch {
                        
                    }
//                    DispatchQueue.main.async {
//                        if let safeData = self.parseJSON(rickAndMortyData: data) {
//                            completion(safeData, nil)
//                        }
//                    }
                }
            }
            task.resume()
        }
    }
    
    
    
    
    
    
    
    
    
    //    func performRequest(endPoint: String, currentPage: Int, completion: @escaping ((RickAndMortyData?)-> ())) {
    //
    //    }
    
    private func parseJSON(rickAndMortyData: Data) {
       
    }
}
