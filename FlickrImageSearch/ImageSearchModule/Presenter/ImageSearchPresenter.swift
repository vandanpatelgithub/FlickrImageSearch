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
    func loadImage(withURL url: String, completion: @escaping (_ imageData: Data?) -> ())
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
    func loadImage(withURL url: String, completion: @escaping (Data?) -> ()) {
        interactor?.getPhoto(forURL: url, completion: { (data, error) in
            if let data = data { completion(data) }
            else { completion(nil) }
        })
    }
    
    func onViewDidLoad() {
        interactor?.getPhotos(forSearchText: "Food", andPageNo: 1, completion: { [weak self] (searchResponse, error) in
            guard let self = self else { return }
            if searchResponse != nil && error == nil, let photos = searchResponse?.photos.photos {
                for photo in photos { self.photosUIModel.append(self.convertToUIModel(photo)) }
                self.view.show(self.photosUIModel)
            }
            else { self.view.show([]) }
        })
    }
}
