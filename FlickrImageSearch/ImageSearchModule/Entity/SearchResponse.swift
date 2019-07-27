//
//  SearchResponse.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/27/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
    let photos: PageInformation
}

struct PageInformation: Codable {
    let currentPage: Int
    let totalPages: Int
    let resultsPerPage: Int
    let totalPhotos: String
    let photos: [Photo]
    
    private enum CodingKeys: String, CodingKey {
        case currentPage = "page"
        case totalPages = "pages"
        case resultsPerPage = "perpage"
        case totalPhotos = "total"
        case photos = "photo"
    }
}
