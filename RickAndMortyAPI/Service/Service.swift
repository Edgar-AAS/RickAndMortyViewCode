//
//  RickAndMortyManager.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 17/08/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidResponse
    case invalidData
}

class WebService {
    static func getAllRequest <T: Codable> (of type: T.Type, from urlService: String, completion: @escaping ((Result<T, Error>) -> ())) {
        
        let urlWihoutSpace = urlService.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: urlWihoutSpace) else {
            completion(.failure(NetworkError.badURL))
            return
        }
                
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if 200...299 ~= response.statusCode {
                guard let jsonData = data else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                
                do {
                    let data: T =  try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
