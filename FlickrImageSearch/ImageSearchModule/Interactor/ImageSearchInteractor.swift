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
    func getPhotos(forSearchText text: String, andPageNo page: Int)
}

class ImageSearchInteractor {
    let networkManager: NetworkManagable
    var presenter: ImageSearchPresentable?
    
    init(networkManager: NetworkManagable) {
        self.networkManager = networkManager
    }
}

// MARK: ImageSearchInteratable Conformation
extension ImageSearchInteractor: ImageSearchInteractable {
    func getPhotos(forSearchText text: String, andPageNo page: Int) {
        networkManager.getPhotos(forSearchText: text, andPageNo: page) { [weak self] (searchResponse, errorString) in
            if errorString != nil { self?.presenter?.didGetPhotos([]) }
            else if searchResponse != nil { self?.presenter?.didGetPhotos(searchResponse?.photos.photos ?? []) }
        }
    }
}
