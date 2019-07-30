//
//  ImageSearchInteractor.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/29/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import Foundation

//MARK: - ImageSearchInteractable Protocol
protocol ImageSearchInteractable: class {
    func getPhotos(forSearchText text: String,
                   andPageNo page: Int,
                   completion: @escaping (_ searchResponse: SearchResponse?, _ error: String?) ->())
    func getPhoto(forURL url: String, completion: @escaping (_ data: Data?, _ error: String?) -> ())
}

class ImageSearchInteractor {
    var presenter: ImageSearchPresentable?
    let networkManager: NetworkManagable
    
    init(networkManager: NetworkManagable) {
        self.networkManager = networkManager
    }
}

// MARK: ImageSearchInteratable Conformation
extension ImageSearchInteractor: ImageSearchInteractable {
    func getPhoto(forURL url: String, completion: @escaping (Data?, String?) -> ()) {
        networkManager.getPhoto(forURL: url, completion: completion)
    }
    
    func getPhotos(forSearchText text: String,
                   andPageNo page: Int,
                   completion: @escaping (SearchResponse?, String?) -> ()) {
        networkManager.getPhotos(forSearchText: text, andPageNo: page, completion: completion)
    }
}
