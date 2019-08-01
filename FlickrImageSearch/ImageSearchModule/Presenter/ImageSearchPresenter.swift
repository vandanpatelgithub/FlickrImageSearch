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
    func didGetPhotos(_ photos: [Photo], totalPages: Int)
    func getNextPagePhotos()
    
    var fetchingMore: Bool { get set }
}

class ImageSearchPresenter {
    let view: ImageSearchViewable
    var interactor: ImageSearchInteractable?
    var photosUIModel = [PhotoUIModel]()
    var currentPage = 0
    var totalPages: Int?
    var fetchingMore: Bool = false
    
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
    func getNextPagePhotos() {
        fetchingMore = true
        currentPage += 1
        if currentPage <= self.totalPages ?? 0 {
          interactor?.getPhotos(forSearchText: "Food", andPageNo: currentPage)
        }
    }
    
    func didGetPhotos(_ photos: [Photo], totalPages: Int) {
        fetchingMore = false
        for photo in photos { self.photosUIModel.append(self.convertToUIModel(photo)) }
        if self.totalPages == nil || self.totalPages != totalPages { self.totalPages = totalPages }
        self.view.show(photosUIModel)
    }
    
    func onViewDidLoad() {
        currentPage = 1
        interactor?.getPhotos(forSearchText: "Food", andPageNo: currentPage)
    }
}
