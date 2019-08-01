//
//  PhotoCell.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/29/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import UIKit

protocol PhotoCellViewable: class {
    func showImage(withData data: Data?)
}

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    var presenter: PhotoCellPresentable?
}

extension PhotoCell: PhotoCellViewable {
    func showImage(withData data: Data?) {
        guard let data = data else { return }
        DispatchQueue.main.async { self.photoImageView.image = UIImage(data: data) }
    }
}
