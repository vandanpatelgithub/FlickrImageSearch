//
//  PhotoCellPresenter.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/31/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import Foundation

protocol PhotoCellPresentable {
    func loadImage()
    func didLoadImageData(_ data: Data?)
}

class PhotoCellPresenter {
    let view: PhotoCellViewable
    let interactor: PhotoCellInteractable
    let photo: PhotoUIModel
    
    init(view: PhotoCellViewable, interactor: PhotoCellInteractable, photo: PhotoUIModel) {
        self.view = view
        self.interactor = interactor
        self.photo = photo
    }
}

extension PhotoCellPresenter: PhotoCellPresentable {
    func didLoadImageData(_ data: Data?) {
        view.showImage(withData: data)
    }
    
    func loadImage() {
        interactor.getPhoto(forURL: self.photo.imageURL)
    }
}
