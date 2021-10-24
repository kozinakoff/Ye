//
//  NetworkManager.swift
//  Ye
//
//  Created by ANDREY VORONTSOV on 24.10.2021.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseUrl = "https://api.kanye.rest"
    
    private init() {}
    
    public func getKanyeQuote(completion: @escaping (Result<Quote, YeError>) -> Void) {
        let endpoint = baseUrl
        guard let url = URL(string: endpoint) else {
            completion(.failure(.NotFound))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let quote = try decoder.decode(Quote.self, from: data)
                completion(.success(quote))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
