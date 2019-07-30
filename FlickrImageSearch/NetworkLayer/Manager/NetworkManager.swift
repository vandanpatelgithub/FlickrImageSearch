//
//  NetworkManager.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/28/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import Foundation

protocol NetworkManagable {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>
    func getPhotos(forSearchText text: String,
                   andPageNo page: Int,
                   completion: @escaping (_ searchResponse: SearchResponse?, _ error: String?) ->())
    func getPhoto(forURL url: String, completion: @escaping (_ data: Data?, _ error: String?) -> ())
}

struct NetworkManager: NetworkManagable {
    static let FlickrAPIKey = "0fe1aaa149e2cd9cfae6d59c927e453f"
    static let responseFormat = "json"
    private let router = Router<FlickrAPI>()
    
    internal func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getPhotos(forSearchText text: String,
                   andPageNo page: Int,
                   completion: @escaping (_ searchResponse: SearchResponse?, _ error: String?) ->()) {
        router.request(.searchMovies(text: text, page: page)) { (data, response, error) in
            guard error == nil else {
                completion(nil, NetworkResponse.networkConnectionError.rawValue)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, NetworkResponse.invalidResponse.rawValue)
                return
            }
            
            let result = self.handleNetworkResponse(response)
            switch result {
            case .success:
                guard let responseData = data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }
                
                do {
                   let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: responseData)
                    completion(searchResponse, nil)
                } catch {
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
                
            case .failure(let networkFailureError):
                completion(nil, networkFailureError)
            }
        }
    }
    
    func getPhoto(forURL url: String, completion: @escaping (_ data: Data?, _ error: String?) -> ()) {
        router.request(.loadImage(forURL: url)) { (data, response, error) in
            guard error == nil else {
                completion(nil, NetworkResponse.networkConnectionError.rawValue)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, NetworkResponse.invalidResponse.rawValue)
                return
            }
            
            let result = self.handleNetworkResponse(response)
            switch result {
            case .success:
                guard let responseData = data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }
                completion(responseData, nil)
            case let .failure(networkFailureError):
                completion(nil, networkFailureError)
            }
        }
    }
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We couldn't decode the response"
    case networkConnectionError = "Please check your network connection"
    case invalidResponse = "Invalid Response"
}

enum Result<String> {
    case success
    case failure(String)
}
