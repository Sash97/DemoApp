//
//  NetworkManager.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 15.07.23.
//

import Foundation

class NetworkManager {
//    static let shared = NetworkManager() // Singleton instance
//
//    private init() {}
    
    func getRequest<CustomModel: Decodable>(urlString: String, completion: @escaping (Result<CustomModel, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            if let data = data {
                do {
                    let decodedObject = try JSONDecoder().decode(CustomModel.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            }
        }
        
        task.resume()
    }
}

