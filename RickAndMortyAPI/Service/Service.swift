//
//  RickAndMortyManager.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 28/03/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidResponse
    case invalidData
}

class WebService {
    static func getAllRequest <T: Codable> (of type: T.Type, from api: String, completion: @escaping ((Result <T, Error>) -> ())) {
        guard let url = URL(string: api) else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if 200...299 ~= response.statusCode {
                guard let data = data else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                
                do {
                    let data: T =  try JSONDecoder().decode(T.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
