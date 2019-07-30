//
//  PhotoCell.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/29/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    var presenter: ImageSearchPresentable?
    
    func populateCell(withPhoto photo: PhotoUIModel) {
        presenter?.loadImage(withURL: photo.imageURL, completion: { [unowned self] (data) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async { self.photoImageView.image = image }
        })
    }
}
