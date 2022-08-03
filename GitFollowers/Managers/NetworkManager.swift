//
//  NetworkManager.swift
//  GitFollowers
//
//  Created by Николай Никитин on 18.07.2022.
//

import UIKit

class NetworkManager {
  
  //MARK: - Properties
  static let shared = NetworkManager()
  let cache = NSCache<NSString, UIImage>()
  private let baseURL = "https://api.github.com/users/"
  
  private init() {}
  
  //MARK: - Methods
  ///  Async method for loading all followers models for current user
  func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
    let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
    guard let url = URL(string: endpoint) else {
      completion(.failure(.invalidUsername))
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
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let followers = try decoder.decode([Follower].self, from: data)
        completion(.success(followers))
      } catch {
        completion(.failure(.invalidData))
      }
    }
    task.resume()
  }

  func getRepos(for username: String, completion: @escaping (Result<[Repo], GFError>) -> Void) {
    let endpoint = baseURL + "\(username)/repos?per_page=200"
    guard let url = URL(string: endpoint) else {
      completion(.failure(.invalidUsername))
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
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let repos = try decoder.decode([Repo].self, from: data)
        completion(.success(repos))
      } catch {
        completion(.failure(.invalidData))
      }
    }
    task.resume()
  }
  
  /// Async method for loading current user info from GitHub
  func getUserInfo(for username: String, completion: @escaping (Result<User, GFError>) -> Void) {
    let endpoint = baseURL + "\(username)"
    guard let url = URL(string: endpoint) else {
      completion(.failure(.invalidUsername))
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
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        let user = try decoder.decode(User.self, from: data)
        completion(.success(user))
      } catch {
        completion(.failure(.invalidData))
      }
    }
    task.resume()
  }
  
  /// Async method for loading and caching user avatar image
  func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
    let cacheKey = NSString(string: urlString)
    if let image = cache.object(forKey: cacheKey) {
      completion(image)
      return
    }
    guard let url = URL(string: urlString) else {
      completion(nil)
      return
    }
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard let self = self,
            error == nil,
            let response = response as? HTTPURLResponse,
            response.statusCode == 200,
            let data = data,
            let image = UIImage(data: data) else {
              completion(nil)
              return
            }
      self.cache.setObject(image, forKey: cacheKey)
      completion(image)
    }
    task.resume()
  }
}
