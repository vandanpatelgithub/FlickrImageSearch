//
//  FlickrAPI.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/28/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import Foundation

enum FlickrMethods: String {
    case searchMethod = "flickr.photos.search"
}

enum FlickrAPIConstants: String {
    case method     = "method"
    case apiKey     = "api_key"
    case text       = "text"
    case format     = "format"
    case page       = "page"
    case validJSON  = "nojsoncallback"
}

public enum FlickrAPI {
    case searchMovies(text: String, page: Int)
}

extension FlickrAPI: EndPointType {
    var baseURL: URL {
        switch self {
        case .searchMovies:
            guard let url = URL(string: "https://www.flickr.com") else {
                fatalError("baseURL could not be configured.")
            }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .searchMovies:
            return "services/rest/"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .searchMovies(let text, let page):
            return .requestParameters(urlParameters: [
                FlickrAPIConstants.method.rawValue: FlickrMethods.searchMethod.rawValue,
                FlickrAPIConstants.apiKey.rawValue: NetworkManager.FlickrAPIKey,
                FlickrAPIConstants.text.rawValue: text,
                FlickrAPIConstants.format.rawValue: NetworkManager.responseFormat,
                FlickrAPIConstants.page.rawValue: "\(page)",
                FlickrAPIConstants.validJSON.rawValue: "\(1)"
                ])
        }
    }
}
