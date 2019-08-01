//
//  PhotoCellInteractor.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/31/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import Foundation

protocol PhotoCellInteractable: class {
    func getPhoto(forURL url: String)
}

class PhotoCellInteractor {
    let networkManager: NetworkManagable
    var cellPresenter: PhotoCellPresentable?
    
    init(networkManager: NetworkManagable) {
        self.networkManager = networkManager
    }
}

extension PhotoCellInteractor: PhotoCellInteractable {
    func getPhoto(forURL url: String) {
        networkManager.getPhoto(forURL: url) { [weak self] (data, errorString) in
            if errorString != nil { self?.cellPresenter?.didLoadImageData(nil) }
            else if data != nil { self?.cellPresenter?.didLoadImageData(data) }
        }
    }
}
