//
//  NetworkManager.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/28/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import Foundation

struct NetworkManager {
    static let FlickrAPIKey = "0fe1aaa149e2cd9cfae6d59c927e453f"
    static let responseFormat = "json"
    private let router = Router<FlickrAPI>()
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We couldn't decode the response"
}
