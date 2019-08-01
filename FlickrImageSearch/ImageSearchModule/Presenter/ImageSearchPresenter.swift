//
//  ImageSearchPresenter.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/29/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import Foundation

// MARK: - ImageSearchPresentable protocol
protocol ImageSearchPresentable: class {
    func onViewDidLoad()
    func didGetPhotos(_ photos: [Photo])
}

class ImageSearchPresenter {
    let view: ImageSearchViewable
    var interactor: ImageSearchInteractable?
    var photosUIModel = [PhotoUIModel]()
    
    init(view: ImageSearchViewable, interactor: ImageSearchInteractable) {
        self.view = view
        self.interactor = interactor
    }
    
    private func convertToUIModel(_ photo: Photo) -> PhotoUIModel {
        return PhotoUIModel(imageURL: Utilities.shared.constructImageURL(for: photo))
    }
}

// MARK: - ImageSearchPresentable Conformation
extension ImageSearchPresenter: ImageSearchPresentable {
    func didGetPhotos(_ photos: [Photo]) {
        for photo in photos { self.photosUIModel.append(self.convertToUIModel(photo)) }
        self.view.show(photosUIModel)
    }
    
    #warning("These are hard coded values")
    func onViewDidLoad() {
        interactor?.getPhotos(forSearchText: "Food", andPageNo: 1)
    }
}
