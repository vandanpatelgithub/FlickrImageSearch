//
//  ImageSearchPresenter.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/29/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import UIKit

enum ImageSearchPresenterConstants {
    static let minimumSearchTextLength = 2
}

// MARK: - ImageSearchPresentable protocol
protocol ImageSearchPresentable: class {
    func didGetPhotos(_ photos: [Photo], totalPages: Int)
    func getNewSearchResults(forSearchTest text: String)
    func getNextPageResults()
    func didSelectImage(_ image: UIImage)
    
    var fetchingMore: Bool { get set }
}

class ImageSearchPresenter {
    let view: ImageSearchViewable
    var interactor: ImageSearchInteractable?
    var router: ImageSearchRouter?
    var photosUIModel = [PhotoUIModel]()
    
    var currentPage = 0
    var totalPages: Int?
    var fetchingMore: Bool = false
    var currentSearchText: String?
    
    
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
    func didSelectImage(_ image: UIImage) {
        router?.navigateToFullImageVC(withImage: image)
    }
    
    func getNextPageResults() {
        currentPage += 1
        fetchingMore = true
        
        guard let searchText = currentSearchText, let totalPages = self.totalPages else { return }
        if currentPage <= totalPages {
           interactor?.getPhotos(forSearchText: searchText, andPageNo: currentPage)
        }
    }
    
    func getNewSearchResults(forSearchTest text: String) {
        currentPage = 1
        currentSearchText = text
        self.photosUIModel.removeAll()
        
        if text.count > ImageSearchPresenterConstants.minimumSearchTextLength {
            view.scrollToTheTop()
            interactor?.getPhotos(forSearchText: text, andPageNo: currentPage)
        } else {
            self.view.show([])
        }
    }
    
    func didGetPhotos(_ photos: [Photo], totalPages: Int) {
        fetchingMore = false
        for photo in photos { self.photosUIModel.append(self.convertToUIModel(photo)) }
        if self.totalPages == nil || self.totalPages != totalPages { self.totalPages = totalPages }
        self.view.show(photosUIModel)
    }
}
