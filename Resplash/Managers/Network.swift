//
//  Network.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/23/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.unsplash.com"
    let cache = NSCache<NSString, UIImage>()
    private init(){}
    
    func getRandomImage(completed: @escaping (Result<PhotoInfo, NetworkError>) -> Void) {
        let endpoint = baseURL + "/photos/random" + "?client_id=" + NetworkKeys.unsplashAPIKey
        guard let url = URL(string: endpoint) else {
            completed(.failure(.test))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.test))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.test))
                return
            }
            guard let data = data else {
                completed(.failure(.test))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let randomPhoto = try decoder.decode(PhotoInfo.self, from: data)
                completed(.success(randomPhoto))
            } catch {
                completed(.failure(.test))
            }
        }
        task.resume()
    }
}
