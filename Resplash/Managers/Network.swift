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
    let cache = NSCache<NSString, UIImage>()
    private let baseURL = "https://api.unsplash.com"
    private init(){}
    
//MARK: - Get Photo Objects
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        //check if image is in cache.
        if let image = cache.object(forKey: cacheKey) {
            //completion handler returns image from cache.
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    //Returns nil if nothing works.
                    completed(nil)
                    return
                }
            //set the object in our cache.
            self.cache.setObject(image, forKey: cacheKey)
            //Return image from network call to the completion handler.
            completed(image)
        }
        task.resume()
    }
    
    func getRandomImageInfo(completed: @escaping (Result<PhotoInfo, NetworkError>) -> Void) {
        let endpoint = baseURL + "/photos/random?client_id=\(NetworkKeys.unsplashAPIKey);orientation=portrait;query=minimal;featured"
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
                let randomPhotoInfo = try decoder.decode(PhotoInfo.self, from: data)
                //image URLs are stored in randomPhoto. Use these to update UIImage cells.
                completed(.success(randomPhotoInfo))
            } catch {
                completed(.failure(.test))
            }
        }
        task.resume()
    }
    
    func getUserPhotos(for username: String, page: Int, completed: @escaping (Result<[PhotoInfo], NetworkError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)/photos?client_id=\(NetworkKeys.unsplashAPIKey);page=\(page);per_page=30"
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
                let userPhotos = try decoder.decode([PhotoInfo].self, from: data)
                //image URLs are stored in randomPhoto. Use these to update UIImage cells.
                completed(.success(userPhotos))
            } catch {
                completed(.failure(.test))
            }
        }
        task.resume()
    }
    
    func getLikedPhotos(for username: String, page: Int, completed: @escaping (Result<[PhotoInfo], NetworkError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)/likes?client_id=\(NetworkKeys.unsplashAPIKey);page=\(page);per_page=30"
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
                let likes = try decoder.decode([PhotoInfo].self, from: data)
                //image URLs are stored in randomPhoto. Use these to update UIImage cells.
                completed(.success(likes))
            } catch {
                completed(.failure(.test))
            }
        }
        task.resume()
    }

    
//MARK: - Get User Objects
    func getPublicProfile(for username: String, page: Int, completed: @escaping (Result<User, NetworkError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)" + "?client_id=" + NetworkKeys.unsplashAPIKey
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
                 let userInfo = try decoder.decode(User.self, from: data)
                 //image URLs are stored in randomPhoto. Use these to update UIImage cells.
                 completed(.success(userInfo))
             } catch {
                 completed(.failure(.test))
             }
         }
         task.resume()
    }
    
    func getUserFollowers(for username: String, page: Int, completed: @escaping (Result<[User], NetworkError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)/followers?client_id=\(NetworkKeys.unsplashAPIKey);page=\(page);per_page=30"
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
                 let userFollowers = try decoder.decode([User].self, from: data)
                 //image URLs are stored in randomPhoto. Use these to update UIImage cells.
                 completed(.success(userFollowers))
             } catch {
                 completed(.failure(.test))
             }
         }
         task.resume()
    }
    
    func getUserFollowing(for username: String, page: Int, completed: @escaping (Result<[User], NetworkError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)/following?client_id=\(NetworkKeys.unsplashAPIKey);page=\(page);per_page=30"
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
                 let userFollowers = try decoder.decode([User].self, from: data)
                 //image URLs are stored in randomPhoto. Use these to update UIImage cells.
                 completed(.success(userFollowers))
             } catch {
                 completed(.failure(.test))
             }
         }
         task.resume()
    }
}
