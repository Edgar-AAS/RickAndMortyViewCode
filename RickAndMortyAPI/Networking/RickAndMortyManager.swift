//
//  RickAndMortyManager.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 28/03/22.
//

import Foundation

struct RickAndMortyManager {
    
    private var urlRickAndMortyAPI = "https://rickandmortyapi.com/api/character/?page="

    func performRequest(endPoint: String, currentPage: Int, completion: @escaping ((RickAndMortyData?)-> ())) {
        if let url = URL(string: urlRickAndMortyAPI + "\(currentPage)" + endPoint) {
            DispatchQueue.global().async {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        completion(nil)
                        return
                    }
                    
                    if let data = data {
                        DispatchQueue.main.async {
                            if let safeData = self.parseJSON(rickAndMortyData: data) {
                                completion(safeData)
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    private func parseJSON(rickAndMortyData: Data) -> RickAndMortyData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RickAndMortyData.self, from: rickAndMortyData)
            let rickAndMortyData = RickAndMortyData(results: decodedData.results)
            return rickAndMortyData
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
}
